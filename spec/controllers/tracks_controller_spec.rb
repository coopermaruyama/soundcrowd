require 'spec_helper'
describe ProductionsController do

before(:each) do
      @production = Production.create!(:title => "test")
      get :show, :id => @production.id
    end
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "Show Productions" do
    render_views
    
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should show an avatar" do
      response.body.should have_selector("img", :class => "avatar")
    end
    
    it "should display proper production title" do
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