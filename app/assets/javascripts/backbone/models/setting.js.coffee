class Walloftweets.Models.Setting extends Backbone.Model
  urlRoot: '/user_settings'
  toJSON: ->
    object = {}
    object[@get("id")] = @get("value")
    object


class Walloftweets.Collections.SettingsCollection extends Backbone.Collection
  model: Walloftweets.Models.Setting
  url: '/user_settings'
  settings: []

  initialize: (nil, options) ->

  get_settings: (key) ->
    @settings = @filter((setting)-> setting.get("key") == key)

  bind_change: (key, callback) ->
    settings = @get_settings(key)
    if settings.length > 0
      settings[0].bind('change', callback)

  # get: (key) ->
  #   settings = @get_settings(key)
# #    console?.log "settings for key #{key}",settings.length
  #   if settings.length > 0
# #      console?.log "found key #{key}:#{settings[0].get("value")}", settings[0]
  #     settings[0].get("value")
  #   else
# #      console?.log "found none for key #{key}"
  #     null

  is_true: (key) ->
    val = @get(key)
    return (val == "true") if val != null
    return false

  toggle: (key) ->
    val = @is_true(key)
    @set(key, @bool_string(!val))

  bool_string: (bool_val) ->
    if bool_val
      return "true"
    else
      return "false"

  # set_settings: (key, value) ->
  #   value = String(value)
  #   results  = @get_settings(key)
  #   if results.length == 0
  #     setting = @add("key": key, "value": value)
  #     console.log(setting)
  #     # @add setting
  #   else
  #     setting = @settings[0]
  #     setting.set("value": value)

  #   setting.save() if window.nickname.length > 0  #only save if we are logged in
  #   setting

