require 'open-uri'

class ThumbController < ApplicationController

  def for_url

    page_url = params[:query]

    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'

    artviper_url = "http://www.website-screenshots.de/artviperx.php?uID=64945b3ebd273094&url=#{page_url}"

    Rails.logger.info "artviper url: #{artviper_url}"

    render :text => open(artviper_url, "rb", :read_timeout => 20).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url="+page_url).read
    #render :text => open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

    #headers['Content-Type'] = 'image/jpeg'
    #headers['Cache-Control'] = 'public'
    #headers['Expires'] = 'Mon, 28 Jul 2020 23:30:00 GMT'
    #open(params[:url]).read
    #open("http://85.25.9.83/artviper.php?userID=64945b3ebd273094&url=http://google.com").read

  end

end
