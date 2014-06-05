class Walloftweets.Models.Setting extends Backbone.Model
  urlRoot: 'user_settings'


class Walloftweets.Collections.SettingsCollection extends Backbone.Collection
  model: Walloftweets.Models.Setting
  url: '/user_settings'

  initialize: (nil, options) ->

  get_settings: (key) ->
    settings = @filter((setting)-> setting.get("key") == key)

  bind_change: (key, callback) ->
    settings = @get_settings(key)
    if settings.length > 0
      settings[0].bind('change', callback)

  get: (key) ->
    settings = @get_settings(key)
#    console?.log "settings for key #{key}",settings.length
    if settings.length > 0
#      console?.log "found key #{key}:#{settings[0].get("value")}", settings[0]
      settings[0].get("value")
    else
#      console?.log "found none for key #{key}"
      null

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

  set: (key, value) ->
    value = String(value)
    settings = @get_settings(key)
    if settings.length == 0
#      console?.log "found none for key #{key}"
      setting = new Walloftweets.Models.Setting
#      console?.log "created setting"
      setting.set("key":key)
#      console?.log "set key"
      setting.set("value": value)
      @add setting
    else
#      console?.log "found some", settings
      setting = settings[0]
      setting.set("value": value)
    setting.save() if window.nickname.length > 0  #only save if we are logged in
    setting