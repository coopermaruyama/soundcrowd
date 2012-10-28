require 'spec_helper'

describe User do

	before { @user = User.new(username: "thecoolestguy", email: "coolguy@gmail.com", password: "1mp0ssibl3") }

	subject { @user }

	describe "relationships" do
	  it { should respond_to(:relationships) }
		it { should respond_to(:followed_users) }
		it { should respond_to(:reverse_relationships) }
		it { should respond_to(:followers) }
		it { should respond_to(:following?) }
		it { should respond_to(:follow!) }
	end

	describe "following" do
	  let(:other_user) { FactoryGirl.create(:user) }
	  before do
	  	@user.save!
	  	@user.follow!(other_user)
	  end

	  it { should be_following(other_user) }
	  its(:followed_users) { should include(other_user) }

	  describe "followed user" do
	    subject { other_user }
	    its(:followers) { should include(@user) }
	  end

	  describe "and unfollowing" do
	    before { @user.unfollow!(other_user) }

	    it { should_not be_following(other_user) }
	    its(:followed_users) { should_not include(other_user) }
	  end
	end

	describe "productions" do
	  it { should respond_to(:productions) }
	end



end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  username               :string(255)
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

