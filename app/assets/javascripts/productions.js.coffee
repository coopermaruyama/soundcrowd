# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# $ ->
# 	$('#new_production').fileupload
# 		dataType: "script"
# 		add: (e, data) ->
# 			types = /(\.|\/)(mp3|wav|aiff)$/i
# 			file = data.files[0]
# 			if types.test(file.type) || types.test(file.name)
# 				data.context = $(tmpl("template-upload", file))
# 				$('#new_production').append(data.context)
# 				data.submit()
# 			else
# 				alert("#{file.name} is not an audio file")
# 	    progress: (e, data) ->
# 			if data.context
# 				progress = parseInt(data.loaded / data.total * 100, 10)
# 				data.context.find('.bar').css('width', progress + '%')
# 	$('.jp-seek-bar,.jp-play-bar').each ->

	
	# $('.jp-jplayer').jPlayer
	# 	ready: ->
	# 		$(this).jPlayer "setMedia"
	# 			mp3: $(this).attr('title')
	# 			oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
	# 	swfPath: "/assets"
	# 	supplied: "mp3, oga"
$ ->
	$('#version_title').keyup ->
		$('input[name=track\\[title\\]]').val $(this).val()
	$('.direct-upload').fileupload
		url: "https://api.soundcloud.com/tracks"
		type: "POST"
		dataType: "json"
		async: true
		autoUpload: true
		dropZone: $('#bounced-file-target')
		dragover: ->
			$(this).closest('.dropZone').addClass('hoverdrop')

		add: (event, data) ->
			$(this).closest('.dropZone').fadeOut(500)
			types = /(\.|\/)(mp3|wav|aiff|m4a)$/i
			file = data.files[0]
			d = SC.prepareRequestURI("/tracks", file)
			d.query.format = "json"
			SC.Helper.setFlashStatusCodeMaps(d.query)
			c = d.flattenParams(d.query)
			if types.test(file.type) || types.test(file.name)
				data.context = $(tmpl("template-upload", file))
				$('.progress-container').append(data.context)

				data.submit()

		send: (e, data) ->

		progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10)
				data.context.find('.bar').css('width', progress + '%')
		# This is what makes everything really cool, thanks to that callback
		# you can now update the progress bar based on the upload progress
			# percent = Math.round((e.loaded / e.total) * 100)
			# $(".bar").css "width", percent + "%"

		fail: (e, data) ->
			console.log "fail"

		success: (data) ->
			console.log data.permalink_url
			url = $(data).find("permalink_url").text()
			$("#real_audio_file").val url # Update the real input in the other form

		done: (event, data) ->
			console.log data
			$('.ui-progress-bar').fadeOut 400

	dropleft = -parseInt($('.drop-text').width()) / 2 + "px"
	$('.drop-text').css('margin-left', dropleft)	