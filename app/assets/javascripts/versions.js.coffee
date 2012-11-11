# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	# $('#nsew_version').fileupload
	# 	dataType: "script"
	# 	add: (e, data) ->
	# 		types = /(\.|\/)(mp3|wav|aiff|m4a)$/i
	# 		file = data.files[0]
	# 		if types.test(file.type) || types.test(file.name)
	# 			data.context = $(tmpl("template-upload", file))
	# 			$('#new_version').append(data.context)
	# 			data.submit()
	# 		else
	# 			alert("#{file.name} is not an audio file")
	# 	progress: (e, data) ->
	# 		if data.context
	# 			progress = parseInt(data.loaded / data.total * 100, 10)
	# 			data.context.find('.bar').css('width', progress + '%')

	$('#version_title').keyup ->
		$('input[name=track\\[title\\]]').val $(this).val()
	$(document).bind 'drop dragover', (e) ->
	    e.preventDefault()
	# $('.dropZone').bind 'fileuploaddragover', (e) ->
	# 	$(this).addClass('hoverdrop')
	# 	console.log "hi"
	$(".dropZone").live 'dragexit dragleave drop',(e) ->
		$(this).removeClass('hoverdrop')

	window.createPlayer = (id, track) ->
		format = /\.m4a/.test(track) ? "m4a" : "mp3"
		$("#jquery-jplayer-" + id).jPlayer
			ready: ->
				$(this).jPlayer "setMedia",
					m4a: track
					mp3: track
					oga: "http://www.jplayer.org/audio/ogg/Miaow-02-Hidden.ogg"


			play: -> # To avoid both jPlayers playing together.
				$(this).jPlayer "pauseOthers"

			swfPath: "/assets"
			supplied: "mp3, oga"
			cssSelectorAncestor: "#jp_container_" + id

	token = $('#version_token').val()
	client_id = $('#version_client_id').val()
	client_secret = $('#version_client_secret').val()


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
			console.log data
			window.response = data
		# Here we get the file url on s3 in an xml doc
			url = data.permalink_url
			$("#real_audio_file	").val url # Update the real input in the other form

		done: (event, data) ->
			$('.ui-progress-bar').fadeOut 400

	dropleft = -parseInt($('.drop-text').width()) / 2 + "px"
	$('.drop-text').css('margin-left', dropleft)	