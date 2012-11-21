class Soundcrowd.Routers.Productions extends Backbone.Router
	routes:
		'productions': 'index'
		'productions/:id': 'show'

	initialize: ->
		@collection = new Soundcrowd.Collections.Productions()
		@collection.fetch()

	index: ->
		view = new Soundcrowd.Views.ProductionsIndex({collection: @collection})
		$('#container').html(view.render().el)

	show: (id) ->
		view = new Soundcrowd.Views.Production({model: @model})