class Comment < ActiveRecord::Base
end
# == Schema Information
#
# Table name: comments
#
#  id              :integer         not null, primary key
#  comment         :string(255)
#  timestamp       :datetime
#  reply_of        :integer
#  production_timestamp :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

