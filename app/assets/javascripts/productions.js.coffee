# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#new_production').fileupload
		dataType: "script"
		add: (e, data) ->
			types = /(\.|\/)(mp3|wav|aiff)$/i
			file = data.files[0]
			if types.test(file.type) || types.test(file.name)
				data.context = $(tmpl("template-upload", file))
				$('#new_production').append(data.context)
				data.submit()
			else
				alert("#{file.name} is not an audio file")
	    progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10)
				data.context.find('.bar').css('width', progress + '%')

	$('.jp-jplayer').jPlayer
		ready: ->
			$(this).jPlayer "setMedia"
				mp3: $(this).attr('title')
				oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
		swfPath: "/assets"
		supplied: "mp3, oga"