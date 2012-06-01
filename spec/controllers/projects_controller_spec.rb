require 'spec_helper'

describe ProjectsController do
  
  before(:each) do
    project = create(:project)
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
 
  
  describe "Show Projects" do
    it "should be successful" do
      get :view, :id => @project
      response.should be_success
    end
  end
  
end