class VersionsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index] 
	def index
		@production = Production.find(params[:production_id])
		redirect_to(@production)
	end

	def new
		@production = Production.find(params[:production_id])
		@parent = Version.find(params[:id])
		@version = @parent.children.build(:user_id => current_user.id, :production_id => params[:production_id])
	end
	
	def create
		@version = Version.new(params[:version])
		@version.save!
		@production = Production.find(params[:version][:production_id])
		redirect_to(@production)
	end

	

	def destroy
	end
	def vote_up
    @version = Version.find(params[:id])
    current_user.unvote_for(@version) if current_user.voted_on?(@version)
    current_user.vote_for(@version)
    respond_to do |format|
      format.js
      format.html {redirect_to :back}
    end
  end

  def vote_down
    @version = Version.find(params[:id])
    current_user.unvote_for(@version) if current_user.voted_on?(@version)
    current_user.vote_against(@version)
    respond_to do |format|
      format.js
      format.html {redirect_to :back}
    end
  end
end
