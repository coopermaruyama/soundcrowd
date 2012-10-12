window.Soundcrowd =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
  	new Soundcrowd.Routers.Tracks
  	Backbone.history.start(pushState: true)

$(document).ready ->
  Soundcrowd.init()
