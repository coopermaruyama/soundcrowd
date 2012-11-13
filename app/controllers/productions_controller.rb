class ProductionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index] 
  def index
    @productions = Production.all
  end

  def new
      @production = current_user.productions.build
      @version = @production.versions.build(:user_id => current_user.id)
  end

  def create

    @production = current_user.productions.new(params[:production].merge(:creator_id => current_user.id))
    @production.save!
    redirect_to(@production)
  end  


  
  def show
    @production = Production.find(params[:id])
    @feature = @production.versions.find(:all).sort { |x,y| x.version_votes.size <=> y.version_votes.size }.last
    @client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
  end

end
