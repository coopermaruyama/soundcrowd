require 'spec_helper'

describe User do
  it "should have many tracks" do
  	@user = FactoryGirl.create(:user)
  	@user.tracks.build.should be_valid
  end
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  program_id             :integer
#  username               :string(255)     default(""), not null
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

