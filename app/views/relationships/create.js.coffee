$("#follow_form").html("<%= escape_javascript(render('shared/unfollow')) %>").fadeIn(500)
$("#followers").html('<%= @user.followers.count %>')