class UserProduction < ActiveRecord::Base
	belongs_to :user
	belongs_to :production
	has_many :versions

end
# == Schema Information
#
# Table name: user_productions
#
#  user_id       :integer
#  production_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

