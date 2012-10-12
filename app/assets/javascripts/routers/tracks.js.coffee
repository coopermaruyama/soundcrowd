class Soundcrowd.Routers.Tracks extends Backbone.Router
	routes:
		'tracks/:id': 'show'

	show: (id) ->
		alert "track #{id}"
