require 'spec_helper'

describe Project do
  before(:each) do
    @project = create(:project)
  end
  it "should be able to add a project given valid attribute" do
    Project.create!(@project)
  end
end
# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  creator_id :integer
#  versions   :integer
#  followers  :integer
#  tags       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  bpm        :integer
#

