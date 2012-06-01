class TagRelation < ActiveRecord::Base
end
# == Schema Information
#
# Table name: tag_relations
#
#  id           :integer         not null, primary key
#  tag_id       :integer
#  tagged_track :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

