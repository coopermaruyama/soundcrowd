class UserProduction < ActiveRecord::Base
	belongs_to :user
	belongs_to :production
	has_many :versions

end
