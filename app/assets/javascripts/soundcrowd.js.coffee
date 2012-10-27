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
	$('.version a').hover(
		->
			unless $(this).children('span.overlay').length
				$(this).append('<span class="overlay"></span>')
			$('span.overlay',this).fadeIn(500)
		,->
			$('span.overlay',this).fadeOut(500)
			window.setTimeout -> 
				$(this).children('span.overlay').remove()
				500
	)