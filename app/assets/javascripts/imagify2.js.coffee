
window.imagify2 = (string, text) ->

  default_response = "<a href=\""+string+"\" class=\"tweet_img_iframe oembed\">"+strTruncate(string,25)+"</a>"

  is_image = /\.(png|jpg|jpeg|gif)/i

  pending_image = "/images/image_pending.png"

  if is_image.test(string)==true
    return "<a href=\""+string+"\" class=\"tweet_img_a\" title=\""+htmlEntities(text)+"\"><img data-original=\""+string+"\" src=\"#{pending_image}\" class=\"img_lazy tweet_img\"></a>"
  
  return default_response
