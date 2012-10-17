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
	window.createPlayer = (id, track) ->
		$("#jquery-jplayer-" + id).jPlayer
			ready: ->
				$(this).jPlayer "setMedia",
					m4a: track
					oga: "http://www.jplayer.org/audio/ogg/Miaow-02-Hidden.ogg"


			play: -> # To avoid both jPlayers playing together.
				$(this).jPlayer "pauseOthers"

			swfPath: "/assets"
			supplied: "m4a, oga"
			cssSelectorAncestor: "#jp_container_" + id



	$('.direct-upload').fileupload
		url: $(this).attr("action")
		type: "POST"
		autoUpload: true
		dataType: "xml" # This is really important as s3 gives us back the url of the file in a XML document
		add: (event, data) ->
			window.audio_file = data.files[0] #save audio object to window for use in making waveform
			types = /(\.|\/)(mp3|wav|aiff|m4a)$/i
			file = data.files[0]
			if types.test(file.type) || types.test(file.name)
				data.context = $(tmpl("template-upload", file))
				$('#new_version').append(data.context)
				$.ajax
					url: "/signed_urls"
					type: "GET"
					dataType: "json"
					data: {doc: {title: data.files[0].name}}
					async: false
					success: (data) ->

						# Now that we have our data, we update the form so it contains all
						# the needed data to sign the request
						$(this).find("input[name=key]").val data.key
						$(this).find("input[name=policy]").val data.policy
						$(this).find("input[name=signature]").val data.signature

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

		# Here we get the file url on s3 in an xml doc
			url = $(data).find("Location").text()
			$("#real_audio_file	").val url # Update the real input in the other form

		done: (event, data) ->
			$('.ui-progress-bar').fadeOut 400
			$('#waveform_form').fileupload('add', {files: window.audio_file})

	$('#waveform_form').fileupload
		url: $(this).attr("action")
		type: "POST"
		autoUpload: false
		dataType: "json" # This is really important as s3 gives us back the url of the file in a XML document
		add: (event, data) ->
			# file = data.files[0]
			# data.context = $(tmpl("template-upload", file))
			# $('#new_version').append(data.context)
			# $.ajax
			# 	url: "/waveform/generate"
			# 	type: "POST"
			# 	dataType: "json"
			# 	data: {file: data.files[0]}
			# 	async: false
			# 	success: (data) ->

			# 		# Now that we have our data, we update the form so it contains all
			# 		# the needed data to sign the request
			# 		console.log "success"

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

		# Here we get the file url on s3 in an xml doc
			obj = $.parseJSON(data.result)
			$("#waveform_file").val obj # Update the real input in the other form

		done: (event, data) ->
			# $('#waveform').fileupload('add', {url: filesurl}) <<<< TODO
			$('.ui-progress-bar').fadeOut 400

