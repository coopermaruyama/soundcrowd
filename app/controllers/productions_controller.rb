class ProductionsController < ApplicationController
  def index
    @productions = Production.all
  end

  def new
    if user_signed_in?
      @production = current_user.productions.build
      @version = @production.versions.build(:user_id => current_user.id)
    else
      redirect_to new_user_session_path, :notice => "You must sign in before creating a production"
    end

  end

  def create
    @production = current_user.productions.create!(params[:production].merge(:creator_id => current_user.id))
  end  


  
  def show
    @production = Production.find(params[:id])
  end
end
