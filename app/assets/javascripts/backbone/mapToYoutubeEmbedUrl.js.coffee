window.mapToYoutubeEmbedUrl = (str) ->
  return "" if str == undefined
  return str if /embed/.test(str) == true
#  String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')
#  return "http://www.youtube.com/embed/617ANIA5Rqs?rel=0&amp;wmode=transparent"
  if /^http:\/\/youtu\.be/.test(str)
#    console?.log "youtu.be:#{str}"
    return str.replace(/^http:\/\/youtu\.be\/([^?&#]*)(?:\?(.*))?/,"http://www.youtube.com/embed/$1?rel=0&amp;wmode=transparent")
  if /youtube\.com/.test(str)
#    console?.log "youtube.com:#{str}"
    return str.replace(/.*youtube\.com\/watch\?v=([^&#]*)((\?|&(.*)))?/,"http://www.youtube.com/embed/$1?rel=0&amp;wmode=transparent")
  return str

window.mapToYoutubeThumbUrl = (str) ->
  return "" if str == undefined
#  String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')
#  return "http://www.youtube.com/embed/617ANIA5Rqs?rel=0&amp;wmode=transparent"
  if /^http:\/\/youtu\.be/.test(str)
#    console?.log "youtu.be:#{str}"
    return str.replace(/^http:\/\/youtu\.be\/([^?&#]*)(?:\?(.*))?/,"http://img.youtube.com/vi/$1/1.jpg")
  if /youtube\.com/.test(str)
#    console?.log "youtube.com:#{str}"
    return str.replace(/.*youtube\.com\/watch\?v=([^&#]*)((\?|&(.*)))?/,"http://img.youtube.com/vi/$1/1.jpg")
  return str

#http://img.youtube.com/vi/<insert-youtube-video-id-here>/1.jpg