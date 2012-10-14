module ProductionsHelper
  def avatar(user)
    if FileTest.exist?("#{Rails.root}/app/assets/images/avatars/#{user.id}.png")
  		then image_tag "avatars/#{user.id}.png", :size => "80x80", :class => "avatar" 
  		else image_tag "avatars/_default.png", :size => "80x80", :class => "avatar" 
  	end
  end
end
