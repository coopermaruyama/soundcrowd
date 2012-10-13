class Version < ActiveRecord::Base
	belongs_to :user_production


	validates :user_id, :presence => true

	attr_accessible :user_id, :forked_from, :audio_file, :source_file
	def user
		User.find(self.user_id)
	end
end
# == Schema Information
#
# Table name: versions
#
#  id            :integer         not null, primary key
#  forked_from   :integer
#  source_file   :string(255)
#  audio_file    :string(255)
#  production_id :integer
#  user_id       :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

