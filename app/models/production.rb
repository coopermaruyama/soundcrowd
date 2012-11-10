class Production < ActiveRecord::Base
	has_many :versions
	has_many :user_productions
	has_many :users, :through => :user_productions
	accepts_nested_attributes_for :versions
	after_create :identify_first_version
	after_commit :set_creator

	attr_accessible :creator_id, :title, :versions_attributes
	# Dont forget to use this model by doing create(:user_id => user.id)!
	def creator
		User.find(self.creator_id)
	end
	#fallback if no creator is passed
	def set_creator
		if self.creator_id == nil
			self.creator_id = self.users.first.id
			self.save
		end
	end
	def identify_first_version
		self.versions.first.update_attribute(:production_id, self.id)
	end
end
# == Schema Information
#
# Table name: productions
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  creator_id :integer
#

