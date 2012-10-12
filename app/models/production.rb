class Production < ActiveRecord::Base
	has_many :versions


end
# == Schema Information
#
# Table name: productions
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

