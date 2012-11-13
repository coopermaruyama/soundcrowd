$ ->
  $(".ratelink").click ->
    return false if $(this).attr('class').match(/disabled/)
    val = $(this).attr("updown")
    theid = $(this).attr("theid")
    $(this).addClass('disabled')
    if val is "up"
      $(this).closest('.votes').find('.ratelink').last().removeClass('disabled')
      $.ajax
        type: "PUT"
        url: "/versions/vote_up?id=" + theid
        success: ->
        	# do something

    else
      $(this).closest('.votes').find('.ratelink').first().removeClass('disabled')
      $.ajax
        type: "PUT"
        url: "/versions/vote_down?id=" + theid
        success: ->
        	# do something