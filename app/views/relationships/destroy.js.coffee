$("#follow_form").html("<%= escape_javascript(render('shared/follow')) %>").fadeIn(500)
$("#followers").html('<%= @user.followers.count %>')