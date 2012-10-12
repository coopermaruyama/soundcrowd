class Version < ActiveRecord::Base
belongs_to :track
attr_accessible :user_id

validates :user_id, :presence => true

end
# == Schema Information
#
# Table name: versions
#
#  id          :integer         not null, primary key
#  forked_from :integer
#  source_file :string(255)
#  audio_file  :string(255)
#  track_id    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

