class Soundcrowd.Views.ProductionsIndex extends Backbone.View

  template: JST['productions/index']


  initialize: ->
  	@collection.on('reset', @render, this)

  render: ->
  	$(@el).html(@template())
  	@collection.each(@appendProduction)
  	this

  appendProduction: (production) ->
  	view = new Soundcrowd.Views.Production(model: production)
  	$('#productions').append(view.render().el)