$("#follow_form").html("<%= escape_javascript(render('shared/follow_production')) %>").fadeIn(500)
$("#production_followers").html('<%= @production.followers.count %>')