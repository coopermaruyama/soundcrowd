class Track < ActiveRecord::Base
belongs_to :user
has_many :versions
attr_accessible :title, :bpm, :tags, :creator_id, :versions, :followers, :user_id

end
# == Schema Information
#
# Table name: tracks
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  versions   :integer
#  followers  :integer
#  tags       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  bpm        :integer
#  user_id    :integer
#

