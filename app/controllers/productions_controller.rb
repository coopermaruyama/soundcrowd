class ProductionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index] 
  def index
    @productions = Production.all
  end

  def new
      @production = current_user.productions.build
      @version = @production.versions.build(:user_id => current_user.id)
  end

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
      :title => params[:production][:title],
      :asset_data => File.new(uploaded_io.path, 'rb')
    })

    @production = current_user.productions.new(params[:production].merge(:creator_id => current_user.id))
    @production.versions.first.audio_file = track.permalink_url
    @production.save!
  end  


  
  def show
    @production = Production.find(params[:id])
  end
end
