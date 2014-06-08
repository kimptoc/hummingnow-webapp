class Walloftweets.Routers.WallRouter extends Backbone.Router
  initialize: (options, init_settings) ->
    @settings = new Walloftweets.Collections.SettingsCollection(init_settings)
    @pending_tweets = new Walloftweets.Collections.TweetsCollection([],options)
    @tweets = new Walloftweets.Collections.TweetsCollection([],options)
    options['model'] = @tweets
    options['settings'] = @settings
    @status = new Walloftweets.Views.TwitterStatusView(options)
    @controls = new Walloftweets.Views.TwitterControlsView(model: @pending_tweets, settings: @settings)
    @initial_held_back = options['initial_held_back']
    @held_back_factor = options['held_back_factor']
    @time_between_twitter_reload = options['time_between_twitter_reload']
    @time_between_tweets_on_page = 7
    @counter = @time_between_twitter_reload
    @counter2 = 0
    @first_pass = true
    @timerEvent()
#    $('#setting-pack').on('click',@settingPackToggle)
    auto_mode = @settings.get("auto_mode")
    if auto_mode == null
      @settings.set("auto_mode",true)
    show_thumbnails = @settings.get("show_thumbnails")
    if show_thumbnails == null
      @settings.set("show_thumbnails",true)
    @update_view = new Walloftweets.Views.TwitterUpdateView
    KeyboardJS.bind.key('p', @controls.doPausePlayToggle)
    KeyboardJS.bind.key('g', @controls.doGridToggle)
    KeyboardJS.bind.key('s', @controls.doShowPending)
    KeyboardJS.bind.key('t', @update_view.statusUpdateClicked)
    KeyboardJS.bind.key('i', @showThumbnailsToggle)
    KeyboardJS.bind.key 'r', =>
      @counter = @time_between_twitter_reload + 1
#      console?.log "r key pressed"
    $('#query-field').on "focusin", ->
      KeyboardJS.enabled(false)
#      console?.log 'query got focus'
    $('#query-field').on "focusout", ->
      KeyboardJS.enabled(true)
#      console?.log 'query lost focus'

  showThumbnailsToggle: =>
    @settings.toggle("show_thumbnails")
#    console?.log("show thumbnails:#{@settings.get("show_thumbnails")}")

  noThumbnails: ->
    !@settings.is_true("show_thumbnails")

  timerEvent: ->
    @counter = @time_between_twitter_reload if @counter == 0
    @pending_tweets.fetch(add: true) if @counter >= @time_between_twitter_reload
    @counter -= 1
#    console?.log "twitter reload counter:", @counter
    show_pending = @settings.is_true("show_pending")
#    console?.log "counter2:",@counter2,@settings.is_true("auto_mode"), show_pending
    if @settings.is_true("auto_mode") or show_pending
      @counter2 += 1
      if @counter2 == @time_between_tweets_on_page or @first_pass or show_pending
        @showSomeTweets() 
        # $("a.oembed").oembed('',embedMethod: 'fill', includeHandle: false, tagClass: 'tweet_img', includeRichMedia: false, includeGeneric: false)
        # $("a.oembed").oembed('',embedMethod: 'fill', includeHandle: false, img_class: 'tweet_img', maxWidth: 20, maxHeight: 20)
        # $("a.oembed").oembed()
        # $("a.oembed").removeClass('oembed')
      @settings.set("show_pending",false) if show_pending
#      console.log "added tweets",some_tweets
#      console.log("displaying tweet #{a_tweet.get("id_str")}/#{- makeDate(a_tweet.get("created_at")).getTime()}")
#    $("#update-timestamp").text("#{moment().format("HH:mm:ss")} - #{@counter} - #{@pending_tweets.length} - #{@tweets.length} - #{$('.tweet').size()}")
    $("#update-timestamp").text("#{moment().format("HH:mm:ss")} ")
    setTimeout((=> @timerEvent()), 1000)

  showSomeTweets: ->
    some_tweets = []
    if @pending_tweets.length > 0
#      console.log @first_pass, @pending_tweets.length
      num_to_show = Math.max(@pending_tweets.length-@initial_held_back,0) if @first_pass
      num_to_show = @pending_tweets.length/@held_back_factor unless @first_pass
      num_to_show = @pending_tweets.length if @settings.is_true("show_pending")
      @first_pass = false
#      console.log "adding #{num_to_show} tweets"
      while num_to_show > 0
        a_tweet = @pending_tweets.last()
#        console.log a_tweet
        @pending_tweets.remove(a_tweet)
        some_tweets.push(a_tweet)
#      @tweets.reset()
        num_to_show -= 1
    @tweets.reset(some_tweets)
    @counter2 = 0


    

