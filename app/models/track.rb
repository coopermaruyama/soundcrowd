class Track < ActiveRecord::Base
	belongs_to :user, :polymorphic => true
	has_many :versions

	

	attr_accessible :title
end
