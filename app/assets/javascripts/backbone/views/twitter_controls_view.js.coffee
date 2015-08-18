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
    @options.settings.add({id: "show_pending", value: "true"}, {merge: true})

  doPack: ->
    @options.settings.add({id: "pack_mode", value: "true"}, {merge: true})
    @showHideControls()

  doGrid: ->
    @options.settings.add({id: "pack_mode", value: "false"}, {merge: true})
    @showHideControls()

  doGridToggle: =>
    @options.settings.toggle("pack_mode")
    @showHideControls()

  doPausePlayToggle: =>
    @options.settings.toggle("auto_mode")
    @showHideControls()

  doPause: ->
    @options.settings.add({id: "auto_mode", value: "false"}, {merge: true})
    @showHideControls()

  doPlay: ->
    @options.settings.add({id: "auto_mode", value: "true"}, {merge: true})
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
    @options = options
    @model.bind('reset',@render)
    @model.bind('add',@render)
    @model.bind('remove',@render)

  render: =>
    $(@el).html(@template( models: @model.toJSON(), settings: @options.settings.toJSON()))
    @showHideControls()

