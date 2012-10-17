class Version < ActiveRecord::Base
	has_ancestry
	belongs_to :user_production

	mount_uploader :audio_file, AudioUploader #for uploading audio files
	mount_uploader :source_file, AudioUploader
	mount_uploader :waveform, WaveformUploader #process waveforms & upload 

	validates :user_id, :presence => true 
	validates :production_id, :presence => true
	before_create :generate_title

	attr_accessible :user_id, :forked_from, :audio_file, :source_file, :production_id, :parent_id, :remote_audio_file_url, :remote_source_file_url, :waveform, :remote_waveform_url #remote attr's are used for being able to use carrierwave's remote file upload helpers.

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

