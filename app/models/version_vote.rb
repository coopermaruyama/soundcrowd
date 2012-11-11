class VersionVote < ActiveRecord::Base
	belongs_to :version
	attr_accessible :user_id, :version_id
end
