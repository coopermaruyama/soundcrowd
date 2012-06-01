class Project < ActiveRecord::Base
attr_accessible :title, :bpm, :tags

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

