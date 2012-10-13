module ProductionsHelper
  def avatar
    if FileTest.exist?("#{Rails.root}/app/assets/images/avatars/#{@production.creator.id}.png")
  		then image_tag "avatars/#{@production.creator.id}.png", :size => "80x80", :class => "avatar" 
  		else image_tag "avatars/_default.png", :size => "80x80", :class => "avatar" 
  	end
  end
end
