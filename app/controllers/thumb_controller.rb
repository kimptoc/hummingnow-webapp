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

    begin
        thumbnail_url = thumbnail_url1
        open(thumbnail_url1, "rb", :read_timeout => 20).read
    rescue Exception => ex
        thumbnail_url = thumbnail_url2
        open(thumbnail_url2, "rb", :read_timeout => 20).read
    end
    Rails.logger.info "thumbnail url: #{thumbnail_url}"
    sleep 6

    render :text => open(thumbnail_url, "rb", :read_timeout => 20).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url="+page_url).read
    #render :text => open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

    #headers['Content-Type'] = 'image/jpeg'
    #headers['Cache-Control'] = 'public'
    #headers['Expires'] = 'Mon, 28 Jul 2020 23:30:00 GMT'
    #open(params[:url]).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

  end

end
