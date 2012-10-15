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
		@version = Version.create!(params[:version])

	end

	

	def destroy
	end

end
