class ProductionFollowersController < ApplicationController


	def create
		@production = Production.find(params[:production_follower][:production_id])
		current_user.follow_production!(@production)
		respond_to do |format|
			format.html { redirect_to @production }
			format.js
		end
	end

	def destroy
		@production = ProductionFollower.find(params[:id]).production
		current_user.unfollow_production!(@production)
		respond_to do |format|
			format.html { redirect_to @production }
			format.js
		end
	end
end