class HomeController < ApplicationController
  def index
    @tracks = Track.all
    @users = User.all
  end
end
