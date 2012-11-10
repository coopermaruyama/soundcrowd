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

  def sc_player(version)
    require 'soundcloud'
    user = User.find(version.user_id)
    # create a client object with your app credentials
    client = Soundcloud.new(:client_id => user.token)

    # get a tracks oembed data
    track_url = version.audio_file
    embed_info = client.get('/oembed', 
      :url => track_url,
      :maxwidth => "440px",
      :maxheight => "110px")

    # print the html for the player widget
    return embed_info['html']
  end
 
end
