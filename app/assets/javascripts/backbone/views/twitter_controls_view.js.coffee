class Walloftweets.Views.TwitterControlsView extends Backbone.View
  template: JST["backbone/templates/twitter_controls_view"]
  el: '#twitter-controls'
  events:
    "click .ctl_pause" : "doPause"
    "click .ctl_play" : "doPlay"
    "click .ctl_grid" : "doGrid"
    "click .ctl_pack" : "doPack"
    "click .ctl_pending" : "doShowPending"

  doShowPending: =>
#    $('.ctl_pending').removeClass('notice')
#    $('.ctl_pending').addClass('warning')
    @options.settings.set("show_pending","true")

  doPack: ->
    @options.settings.set("pack_mode","true")
    @showHideControls()

  doGrid: ->
    @options.settings.set("pack_mode","false")
    @showHideControls()

  doGridToggle: =>
    @options.settings.toggle("pack_mode")
    @showHideControls()

  doPausePlayToggle: =>
    @options.settings.toggle("auto_mode")
    @showHideControls()

  doPause: ->
    @options.settings.set("auto_mode","false")
    @showHideControls()

  doPlay: ->
    @options.settings.set("auto_mode","true")
    @showHideControls()

  showHideControls: ->
    if @options.settings.is_true("auto_mode")
      $(".ctl_pause").show()
      $(".ctl_play").hide()
    else
      $(".ctl_pause").hide()
      $(".ctl_play").show()
    if @options.settings.is_true("pack_mode")
      $(".ctl_pack").hide()
      $(".ctl_grid").show()
    else
      $(".ctl_pack").show()
      $(".ctl_grid").hide()

  initialize: (options) ->
    @model.bind('reset',@render)
    @model.bind('add',@render)
    @model.bind('remove',@render)

  render: =>
#    console?.log "controls view render", @model
    $(@el).html(@template( models: @model.toJSON(), settings: @options.settings.toJSON()))
    @showHideControls()

