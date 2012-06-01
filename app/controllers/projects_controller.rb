class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def view
    @project = Project.find(params[:id])
  end
  
  def show
    @project = Project.find(params[:id])
    render 'view'
  end
end
