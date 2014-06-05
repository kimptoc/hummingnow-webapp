#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Walloftweets =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

window.makeDate = (utc_date) ->
  dtstr = utc_date.replace(/\D/g," ")
  dtcomps = dtstr.split(" ")
  # modify month between 1 based ISO 8601 and zero based Date
  dtcomps[1]--
  convdt = new Date(Date.UTC(dtcomps[0],dtcomps[1],dtcomps[2],dtcomps[3],dtcomps[4],dtcomps[5]))

#window.hash_url = (q) -> "https://twitter.com/#!/search?q=#{q}"
window.hash_url = (q) ->
  new_url = "/search/#{encodeURIComponent('#')+q}/#{window.nickname}"
  return new_url

#window.user_url = (q) -> "https://twitter.com/intent/user?screen_name=#{q}"
window.user_url = (q) -> "/user/#{q}/#{window.nickname}"

window.tweet_colour_class = (usr,tw_usr,txt) ->
  return "tweet_mine" if tw_usr == usr
  return "tweet_mention" if txt.indexOf(usr) >= 0

