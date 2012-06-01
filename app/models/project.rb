class Project < ActiveRecord::Base
attr_accessor :title, :creator_id, :versions, :followers, :tags, :bpm
attr_accessible :title, :bpm
end
# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  creator_id :integer
#  versions   :integer
#  followers  :integer
#  tags       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  bpm        :integer
#

