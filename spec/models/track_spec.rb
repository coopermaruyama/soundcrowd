require 'spec_helper'

describe Track do
  before(:each) do
    @track = FactoryGirl.create(:track)
  end
  it "should be able to add a track given valid attribute" do
    @track.bpm.should eq(120)
  end
end
# == Schema Information
#
# Table name: tracks
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  versions   :integer
#  followers  :integer
#  tags       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  bpm        :integer
#  user_id    :integer
#

