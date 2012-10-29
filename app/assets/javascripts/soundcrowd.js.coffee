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
	$('.lighten').hover(
		->
			unless $(this).children('span.overlay').length
				$(this).append('<span class="overlay"></span>')
			$('span.overlay',this).fadeIn(350)
		,->
			$('span.overlay',this).fadeOut(350)
			window.setTimeout -> 
				$(this).children('span.overlay').remove()
				350
	)