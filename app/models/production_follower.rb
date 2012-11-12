class ProductionFollower < ActiveRecord::Base
	belongs_to :production
	belongs_to :user
	attr_accessible :user_id, :production_id
end
