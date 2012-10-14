class VersionsController < ApplicationController


	def index
		@production = Production.find(params[:production_id])
		redirect_to(@production)
	end

	def new
		@production = Production.find(params[:production_id])
		@parent = Version.find(params[:id])
		@version = Version.new(:parent_id => @parent.id, :user_id => current_user.id, :production_id => params[:production_id])
	end
	
	def create
		@version = Version.create!(params[:version])

	end

	

	def destroy
	end

	# def create_child
	# 	@parent_version = Version.find(params[:id])
	# 	@version = @parent_version.versions.build(
	# 		:user_id => current_user.id,
	# 		:production_id => @parent_version.production_id,
	# 		:parent => @parent_version
	# 		)
	# end

	# def new_child
	# 	@parent_version = Version.find(params[:id])
	# 	@version = @parent_version.versions.build(
	# 		:user_id => current_user.id,
	# 		:production_id => @parent_version.production_id,
	# 		:parent => @parent_version
	# 		)
	# end
end
