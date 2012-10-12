class Production < ActiveRecord::Base
	has_many :versions
	has_many :user_productions
	has_many :users, :through => :user_productions

	validates :user_id, :presence => true

	# Dont forget to use this model by doing create(:user_id => user.id)!

end
# == Schema Information
#
# Table name: productions
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

