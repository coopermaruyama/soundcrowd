class Track < ActiveRecord::Base
end
# == Schema Information
#
# Table name: tracks
#
#  id          :integer         not null, primary key
#  creator     :integer
#  votes       :integer
#  forks       :integer
#  original    :boolean
#  forked_from :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  vsts        :string(255)
#

