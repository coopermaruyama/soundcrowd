class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(params[:track])
    if @track.save
      format.html { redirect_to(@track, :notice => "Track successfully created!") }
      format.xml  { render :xml => @track, :status => :created, :location => @track }
    else
      format.html { redirect_to new_track_path(:current) }
      format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
    end
  end  


  
  def show
    @track = Track.find(params[:id])
  end
end
