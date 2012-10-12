class HomeController < ApplicationController
  def index
    @productions = Production.all
    @users = User.all
  end
end
