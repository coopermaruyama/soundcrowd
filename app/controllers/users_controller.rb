class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    @program = Program.find(@user.program_id)
  end

  def edit
    @user = User.find(params[:id])
  end
end
