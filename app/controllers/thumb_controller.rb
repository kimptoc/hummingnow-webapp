require 'open-uri'

class ThumbController < ApplicationController

  def for_url

    page_url = params[:query]

    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'

    Rails.logger.info "Generating thumbnail url for:#{page_url}"

    # thumbnail_url = "http://www.website-screenshots.de/artviperx.php?uID=#{Figaro.env.artviper_uid}&url=#{page_url}"
    # if (rand < 0.5)
        thumbnail_url1 = "https://api.thumbalizr.com/?api_key#{Figaro.env.thumbalizr_uid}=&url=#{page_url}"
    # else
        thumbnail_url2 = "http://images.shrinktheweb.com/xino.php?stwembed=1&stwaccesskeyid=#{Figaro.env.shrinktheweb_uid}&stwsize=sm&stwurl=#{page_url}"
    # end

    thumbnail_url = try_url(thumbnail_url1)
    if thumbnail_url == ""
      thumbnail_url = try_url(thumbnail_url2)
      if thumbnail_url == ""
        thumbnail_url = try_url("http://w3layouts.com/wp-content/uploads/2013/05/poses-404-web.png")
      end
    end

    #begin
    #    thumbnail_url = thumbnail_url1
    #    response_code = ""
    #    while response_code !~ /200|500/
    #        response_code = check_url_header(thumbnail_url)
    #        raise "Error" if response_code == "500"
    #        sleep 10 unless response_code == "200"
    #    end
    #    # open(thumbnail_url, "rb", :read_timeout => 20).read
    #rescue Exception => ex
    #  begin
    #    thumbnail_url = thumbnail_url2
    #    check_url_header(thumbnail_url)
    #    open(thumbnail_url, "rb", :read_timeout => 20).read
    #  rescue Exception => ex2
    #    thumbnail_url = "http://w3layouts.com/wp-content/uploads/2013/05/poses-404-web.png"
    #    check_url_header(thumbnail_url)
    #    open(thumbnail_url, "rb", :read_timeout => 20).read
    #  end
    #end

    Rails.logger.info "thumbnail url: #{thumbnail_url}"
    # sleep 6

    render :text => open(thumbnail_url, "rb", :read_timeout => 20).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url="+page_url).read
    #render :text => open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

    #headers['Content-Type'] = 'image/jpeg'
    #headers['Cache-Control'] = 'public'
    #headers['Expires'] = 'Mon, 28 Jul 2020 23:30:00 GMT'
    #open(params[:url]).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

  end

  def try_url(url)
    thumbnail_url = url
    tries = 1
    begin
        response_code = ""
        while response_code != "200" && tries < 6
            response_code = check_url_header(thumbnail_url)
            tries += 1
            raise "Error" if response_code == "500"
            sleep 10 unless response_code == "200"
        end
        raise "Error" if response_code != "200"
    rescue Exception => ex
      thumbnail_url = ""
    end
    thumbnail_url
  end

  def check_url_header(url)
    @@check_id ||= 0
    @@check_id += 1
    this_check_id = @@check_id
    Rails.logger.info "[#{this_check_id}]Checking url start:#{url}"
    uri = URI(url)
    response_code = ""
    #proxy_addr = 'localhost'
    #proxy_port = 8888
    proxy_addr = nil
    proxy_port = nil
    Net::HTTP.start(uri.host, uri.port, proxy_addr, proxy_port, 
        :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
        begin
            path_query = "#{uri.path}?#{uri.query}"
            Rails.logger.info "path/query:#{path_query}"
            response = http.head(path_query)
            Rails.logger.info "[#{this_check_id}]Response code:#{response.code}/#{response.message}"
            response_code = response.code
            response.each do |k, v| 
                Rails.logger.info "[#{this_check_id}]#{k}: #{v}" 
                response_code = 302 if k.downcase == "x-thumbalizr-status" && v.downcase == "queued"
            end
        rescue Exception => ex
            Rails.logger.info "Exception in block processing:#{url}"
            Rails.logger.info ex
        end
    end
    Rails.logger.info "[#{this_check_id}]Checking url end:#{url}"
    response_code
   rescue Exception => ex
    Rails.logger.info "Exception processing:#{url}"
    Rails.logger.info ex
    response_code
  end
end
