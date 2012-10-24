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
    @production = current_user.productions.create!(params[:production].merge(:creator_id => current_user.id))
  end  


  
  def show
    @production = Production.find(params[:id])
  end
end
