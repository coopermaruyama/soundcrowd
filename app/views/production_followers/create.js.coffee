$("#follow_form").html("<%= escape_javascript(render('shared/unfollow_production')) %>").fadeIn(500)
$("#production_followers").html('<%= @production.followers.count %>')