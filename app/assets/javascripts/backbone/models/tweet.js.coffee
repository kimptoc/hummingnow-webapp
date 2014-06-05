class Walloftweets.Models.Tweet extends Backbone.Model


class Walloftweets.Collections.TweetsCollection extends Backbone.Collection
  model: Walloftweets.Models.Tweet

  initialize: (nil, options) ->
    @last_tweet_id = ''
    @url_root = options['url_root']

  url: =>
    return @url_root unless @last_tweet_id
    return "#{@url_root}?since_id=#{@last_tweet_id}"

  fetch: (options)->
    options["success"] = @onFetchSuccess
    super(options)

  onFetchSuccess: (collection, response) =>
    @last_tweet_id = collection.max( (tw)-> tw.get("id_str")).get("id_str") if collection.length > 0
#    console?.log("last tweet id:#{@last_tweet_id}", @models)

  comparator: (tweet) ->
    -parseInt(tweet.get("sort_time"))