class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def create
  end  


  
  def show
    @track = Track.find(params[:id])
  end
end
