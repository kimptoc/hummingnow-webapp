class Walloftweets.Views.TwitterUpdateView
  template: JST["backbone/templates/twitter_update_view"]

  constructor: (original_tweet_id = null, original_tweet_user = null, original_tweet_text = null, is_retweet = false)->
#    console?.log "update view ctor"
    @original_tweet_id=original_tweet_id
    @original_tweet_user="@#{original_tweet_user} " if original_tweet_user
    @original_tweet_text="RT #{original_tweet_text}" if original_tweet_text
    @is_retweet = is_retweet
    $('#status-update').on('click', @statusUpdateClicked) unless original_tweet_id

  statusUpdateClicked: =>
    KeyboardJS.enabled(false)
#    bootbox.confirm("Hello world!", "Cancel","Tweet!")
    original_tweet_id = @original_tweet_id
    buttons = []
    retweet_button = {}
    if @is_retweet
      buttons.push
        "label" : "Just Retweet"
        "class" : "success"
        "callback" : ->
#          console?.log("just retweet")
          $.ajax
            url: "/retweet/#{window.nickname}"
            type: 'POST'
            data:
              original_tweet_id: original_tweet_id
            success: ->
              console?.log "retweeted ok"
              KeyboardJS.enabled(true)
            error: ->
              console?.log "did not retweet ok!"
              KeyboardJS.enabled(true)
    buttons.push
      "label" : "Cancel"
      "class" : "danger"
      "callback": ->
        KeyboardJS.enabled(true)
  #        console?.log("cancelled - anything to do?")
    buttons.push
      "label" : "Tweet!"
      "class" : "primary"
      "callback": ->
#        console?.log("Tweet time")
        update_text = $('#status-update-text').val()
#        console?.log original_tweet_id
        $.ajax
          url: "/tweet/#{window.nickname}"
          type: 'POST'
          data:
            original_tweet_id: original_tweet_id
            tweet: update_text
          success: ->
            console?.log "tweeted ok"
            KeyboardJS.enabled(true)
          error: ->
            console?.log "did not tweet ok!"
            KeyboardJS.enabled(true)
    bootbox.dialog(@template(tweet_user: @original_tweet_user, tweet_text: @original_tweet_text), buttons,
      keyboard: true).bind('shown', (-> $("#status-update-text").focus().putCursorAtEnd().charCount(warning : 20) ))
