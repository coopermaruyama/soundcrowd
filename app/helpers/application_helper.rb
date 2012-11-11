module ApplicationHelper
	def avatar(user)
    response = HTTParty.get("http://api.soundcloud.com/users/#{user.uid}.json?client_id=#{ENV['SOUNDCLOUD_CLIENT_ID']}")
  	image_tag response['avatar_url'], :size => "80x80", :class => "avatar" 
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
    begin
      embed_info = client.get('/oembed', 
        :url => track_url,
        :show_artwork => false,
        :show_bpm => true,
        :show_comments =>true,
        :download => true,
        :maxwidth => "440px",
        :maxheight => "160px")
      return embed_info['html']
    rescue
      return "<div class='processing'>This track is still processing. Check back soon.</div>"
    end
    # print the html for the player widget
    
  end
 
end
