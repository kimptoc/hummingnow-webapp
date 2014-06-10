
window.imagify = (string, text) ->

  default_response = "<a href=\""+string+"\" class=\"tweet_img_iframe\">"+strTruncate(string,25)+"</a>"
  if window.wall_app_router.noThumbnails()
    return default_response

#//    console.log(string);
#//"<a href=\"$&\">"+imagify("$&")+"</a>"
#//    console.log(String(string))

  #//    http://api.instagram.com/oembed?url=http://instagr.am/p/BUG/

  pending_image = "/images/image_pending.png"

  if /\.(png|jpg|jpeg|gif)/i.test(string)==true
    return "<a href=\""+string+"\" class=\"tweet_img_a\" title=\""+htmlEntities(text)+"\"><img data-original=\""+string+"\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"

  if /^http:\/\/instagr\.?am/.test(string)==true
#//        string = "http://api.instagram.com/oembed?url="+string;
    thumb_img = "#{string}media/?size=t"
#//        var medium_img = string +"media/";
#//        return "<a href=\""+medium_img+"\" class=\"tweet_img_iframe\" title=\""+htmlEntities(text)+"\"><img src=\""+thumb_img+"\" class=\"tweet_img\"></a>";
    return "<a href=\""+string+"\" class=\"tweet_img_iframe\"><img data-original=\""+thumb_img+"\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"

  if /^http:\/\/flic\.kr/.test(string)==true
#//        console.log("flickr:"+string);
#//        tester="http://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg";
    return "<a href=\""+string+"\">"+strTruncate(string,25)+"</a>"
#//        return "<a href=\""+string+"\" class=\"tweet_img_iframe\"><img data-original=\""+string+"\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>";

  if /^https?:\/\/vimeo/.test(string)==true
      string = string.replace(/\/m\//,'/')
      return "<a href=\""+string+"\" class=\"tweet_img_iframe oembed\">"+strTruncate(string,25)+"</a>"

  if /^https?:\/\/.*pinterest/.test(string)==true
      return "<a href=\""+string+"\" class=\"tweet_img_iframe oembed\">"+strTruncate(string,25)+"</a>"

  if /^http:\/\/.*youtu/.test(string)==true
    embed_url = mapToYoutubeEmbedUrl(string)
    thumb_url = mapToYoutubeThumbUrl(string)
#//        return "<a href=\""+embed_url+"\" class=\"link_youtube\">"+strTruncate(string,25)+"</a>";
    return "<a href=\""+embed_url+"\" class=\"link_youtube\"><img data-original=\""+thumb_url+"\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"
#//        return '<iframe width="60" height="60" src="http://www.youtube.com/embed/ELeybmLVTSw" frameborder="0" allowfullscreen></iframe>';

  if /^http:\/\/yfrog\.com\//.test(string)==true
    return "<a href=\"#{string}\" class=\"tweet_img_iframe\" title=\"#{htmlEntities(text)}\"><img data-original=\"#{string}:small\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"

  if /^http:\/\/twitpic\.com\//.test(string)==true
    thumb_img = string.replace(/^http:\/\/twitpic\.com\/(.*)/, "http://twitpic.com/show/thumb/$1")
    return "<a href=\"#{string}\" class=\"tweet_img_iframe\" title=\"#{htmlEntities(text)}\"><img data-original=\"#{thumb_img}\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"

#http://plixi.com/p/38564586
#To get the thumbnail of this post, use the URL http://api.plixi.com/api/tpapi.svc/imagefromurl?size=thumbnail&url=http://plixi.com/p/38564586

  if /^http:\/\/plixi\.com\//.test(string)==true
    return "<a href=\"#{string}\" class=\"tweet_img_iframe\" title=\"#{htmlEntities(text)}\"><img data-original=\"http://api.plixi.com/api/tpapi.svc/imagefromurl?size=thumbnail&url=#{string}\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"

#  console?.log "count:#{window.imagify_website_count}, max:#{window.imagify_website_max}"

  if window.imagify_website_count > window.imagify_website_max
    return default_response

  window.imagify_website_count += 1
  thumb_server = 1 + (window.imagify_website_count % 2)

  console.log("Trying to gen thumbnail for:#{string}")

  # return "<a href=\"#{string}\" class=\"tweet_img_iframe\" title=\"#{htmlEntities(text)}\"><img data-original=\"http://hummingnow-thumbs#{thumb_server}.herokuapp.com/thumb/#{encodeURIComponent(string)}\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"
  return "<a href=\"#{string}\" class=\"tweet_img_iframe\" title=\"#{htmlEntities(text)}\"><img data-original=\"http://localhost:3000/thumb/#{encodeURIComponent(string)}\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"
