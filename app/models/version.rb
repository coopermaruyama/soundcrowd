class Version < ActiveRecord::Base
	belongs_to :production
	attr_accessible :user_id, :production_id

	after_create :associate_user

	def associate_user
		@users = User.all(:include => :productions, :conditions => {"productions_users.production_id" => self.production_id})
		@users.each do |user|
			user.productions.each do |production|
				if production.versions.exists?(self)
					@version_user = user
				end
			end
		end
		self.user_id = @version_user.id
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

