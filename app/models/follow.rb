class Follow < ActiveRecord::Base
end
# == Schema Information
#
# Table name: follows
#
#  id          :integer         not null, primary key
#  followed_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  follower_id :integer
#

