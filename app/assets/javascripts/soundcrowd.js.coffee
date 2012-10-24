window.Soundcrowd =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
  	new Soundcrowd.Routers.Productions
  	Backbone.history.start(pushState: true)

$(document).ready ->
  Soundcrowd.init()
