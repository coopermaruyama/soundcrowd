class User < ActiveRecord::Base
  attr_accessible :username, :program_id, :email, :password
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  password   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email      :string(255)
#  program_id :integer
#

