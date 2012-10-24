require 'spec_helper'

describe ProductionsController do
  
  before(:each) do
    @project = create(:project)
    @user = create(:user)
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "Show Projects" do
    render_views
    before(:each) do
      get :show, :id => @project.id
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should show an avatar" do
      response.body.should have_selector("img", :class => "avatar")
    end
    
    it "should display proper project title" do
      response.body.should have_selector("h1", :class => "title", :content => "A City in Florida")
    end
    
    it "should display the creator's name" do
      response.body.should have_selector("span", :class => "creator-info", :content => "deadmau5")
    end
    
    it "should link to the creator's profile" do
      response.body.should have_selector("a", :content => 'deadmau5', :href => '/users/1')
    end
  end
  
end