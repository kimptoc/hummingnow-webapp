class Walloftweets.Views.TwitterStatusView extends Backbone.View
  template: JST["backbone/templates/twitter_status_view"]
  el: '#twitter-status'

  initialize: (options) ->
    parentWidth = $(@el).width()
    numCols = parseInt(parentWidth / 200)
    @colWidth = $(@el).width() / numCols - 5
    $(@el).masonry( itemSelector: '.tweet', isAnimated: !Modernizr.csstransitions,
      isResizable: true, isFitWidth: true, columnWidth: @colWidth )
    @model.bind('reset',@render)
#    @model.bind('add',@render)
    $(@el).html("<br>Loading tweets...");
    @first_pass = true
    pack_mode = options.settings.get("pack_mode")
    if pack_mode == null
      options.settings.set("pack_mode",false)
    options.settings.bind_change('pack_mode',@renderPackMode)
    window.imagify_website_max = 15
    window.imagify_website_count = 1

  renderPackMode: (doReload = true) =>
    if @options.settings.is_true("pack_mode")
      $('.tweet').css('height','')
    else
      $('.tweet').css('height','150px')
    $(@el).masonry( 'reload' ) if doReload

  render: =>
    # todo - make $ a local variable... measure change...
    window.imagify_website_count = 1
    if @first_pass and @model.length > 0
      $(@el).html("")
      @first_pass = false
#    console.log("model:#{@model.length}",@model)
    $('.new_tweet').removeClass('new_tweet')
    $('img.img_lazy').removeClass('img_lazy')
    $(@el).prepend(@template( models: @model.toJSON(), dm_mode: @options?['dm_mode'] ? false ))
    $('.tweet').css('width',@colWidth)
    $('.reply-action').on('click',@handleReplyAction)
    $('.reply-action').removeClass('reply-action')
    $('.retweet-action').on('click',@handleRetweetAction)
    $('.retweet-action').removeClass('retweet-action')
    $('.new_tweet_text').linkify(hash_url, user_url)
    $('.new_tweet_text').removeClass('new_tweet_text')
    $('.tweet').slice(200).remove()
    $('.tweet_img_a').colorbox transition:"fade", opacity:0.65, top:"50px",  maxWidth:"95%", maxHeight:"90%"
    $('.tweet_img_iframe').colorbox iframe:true, transition:"fade", opacity:0.65, top:"50px", width:"95%", height:"90%"
    $('.link_youtube').colorbox iframe:true, transition:"fade", opacity:0.65, top:"50px", width:"95%", height:"90%"
    #recalc from now strings
    $('.tweet_time').each ->
      tweet = $(this)
#      console.log(moment(tweet.attr("tweet_ts")).fromNow())
      $(".tweet_from_now",tweet).text(moment(makeDate(tweet.attr("tweet_ts"))).fromNow())
    $("img.img_lazy").lazyload
      effect : "fadeIn"
      failure_limit : 10
      threshold : 200
      event: "scrollstop"
    @renderPackMode(@model.length > 0)

  handleReplyAction: (event)->
    tweet_id = $(event.currentTarget).attr('tweet_id')
    tweet_user = $(event.currentTarget).attr('tweet_user')
#    console?.log "handeReplyAction", tweet_id, tweet_user
    replyView = new Walloftweets.Views.TwitterUpdateView(tweet_id, tweet_user)
    replyView.statusUpdateClicked()

  handleRetweetAction: (event)->
    tweet_id = $(event.currentTarget).attr('tweet_id')
    tweet_text = $(event.currentTarget).attr('tweet_text')
#    console?.log "handeRetweetAction", tweet_id, tweet_text
    retweetView = new Walloftweets.Views.TwitterUpdateView(tweet_id, null, tweet_text, true)
    retweetView.statusUpdateClicked()

