class User < ActiveRecord::Base
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  password   :string(255)
#  program    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email      :string(255)
#

