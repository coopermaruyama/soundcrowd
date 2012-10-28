module ApplicationHelper
	
	def avatar(user)
    if FileTest.exist?("#{Rails.root}/app/assets/images/avatars/#{user.id}.png")
  		then image_tag "avatars/#{user.id}.png", :size => "80x80", :class => "avatar" 
  		else image_tag "avatars/_default.png", :size => "80x80", :class => "avatar" 
  	end
  end
	  
  def logo
    image_tag("logo.png", :alt => 'SoundCrowd', :class=> 'logo')
  end
  
  def nested_versions(versions)
    versions.map do |version, sub_versions|
      render(version) + content_tag(:div, nested_versions(sub_versions), :class => "nested_versions")
    end.join.html_safe
  end

 
end
