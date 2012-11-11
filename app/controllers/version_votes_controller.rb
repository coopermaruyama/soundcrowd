class VersionVotesController < ApplicationController
	def create
		@vote = VersionVote.new(params[:version_vote])
		@vote.user_id = current_user.id
		@vote.save!
	end
end