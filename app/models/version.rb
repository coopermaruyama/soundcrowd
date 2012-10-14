class Version < ActiveRecord::Base
	has_ancestry
	belongs_to :user_production
	has_many :versions, :class_name => "Version", :foreign_key => "original_id"
	belongs_to :original, :class_name => "Version"

	mount_uploader :audio_file, AudioUploader #for uploading audio files

	validates :user_id, :presence => true 
	validates :production_id, :presence => true
	
	attr_accessible :user_id, :forked_from, :audio_file, :source_file, :production_id, :parent_id

	before_create :generate_title

	def generate_title
		if self.title.blank?
			self.title = /[:word:]-[:word:]-\d{1}/.gen
		end
	end
	
	def user
		User.find(self.user_id)
	end
end
# == Schema Information
#
# Table name: versions
#
#  id            :integer         not null, primary key
#  source_file   :string(255)
#  audio_file    :string(255)
#  production_id :integer
#  user_id       :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  original_id   :integer
#

