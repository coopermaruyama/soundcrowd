class Version < ActiveRecord::Base
	has_ancestry
	belongs_to :user_production

	mount_uploader :audio_file, AudioUploader #for uploading audio files
	# mount_uploader :source_file, AudioUploader
	mount_uploader :waveform, WaveformUploader #process waveforms & upload 

	validates :user_id, :presence => true 
	validates :production_id, :presence => true
	before_create :generate_title
	after_save :generate_waveform

	attr_accessible :user_id, :forked_from, :audio_file, :source_file, :production_id, :parent_id, :remote_audio_file_url, :remote_source_file_url, :waveform, :remote_waveform_url #remote attr's are used for being able to use carrierwave's remote file upload helpers.

	def generate_title
		if self.title.blank?
			self.title = rand(999).to_s
		end
	end
	
	def user
		User.find(self.user_id)
	end

	def get_url
		self.audio_file_url.split('/')[0..-2].join('/') + "/" + CGI.escape(self.audio_file_url.split('/')[-1])
	end

	def generate_waveform
		if self.waveform.blank?
			source = self.get_url.to_s.gsub("https","http")
		    file = `ffmpeg -i #{source} -f wav -y 'public/converted.wav'`
	        wave = `waveform -W360 -H55 -ctransparent -b#ffffff -mpeak -F 'public/converted.wav' 'public/waveform.png'`
	        self.waveform = File.open('public/waveform.png')
	        self.save!
       end
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

