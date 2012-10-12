class Version < ActiveRecord::Base
	belongs_to :user
	belongs_to :track

	attr_accessible :user_id
end
# == Schema Information
#
# Table name: versions
#
#  id          :integer         not null, primary key
#  votes       :integer
#  forks       :integer
#  original    :boolean
#  forked_from :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  vsts        :string(255)
#  user_id     :integer
#  project_id  :integer
#

