class ScTracksController < ApplicationController
	def create
		require 'soundcloud'
    #create a client object with access token
    client = Soundcloud.new(:access_token => current_user.token)
    uploaded_io = params[:sc_audio]
     # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
     #    file.write(uploaded_io.read)
     #  end
    # upload an audio file
    track = client.post('/tracks', :track => {
      :title => "params[:title]",
      :asset_data => File.new(uploaded_io.path, 'rb')
    })
    return track.permalink_url
	end
end