class Version < ActiveRecord::Base
	belongs_to :user_production



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

