class Soundcrowd.Views.Production extends Backbone.View

  template: JST['productions/production']
  tagName: 'li'


  render: ->
  	$(@el).html(@template(production: @model))
  	this
