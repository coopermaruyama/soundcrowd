class VersionVote < ActiveRecord::Base
	belongs_to :version
	attr_accessible :user_id, :version_id
	validates_uniqueness_of :version_id, :scope => [:user_id]
end
