class ScplayerController < ApplicationController
	def show
		@version = Version.find(params[:id])
		@client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
		render :layout => false
	end
end