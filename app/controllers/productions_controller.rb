class ProductionsController < ApplicationController
  def index
    @productions = Production.all
  end

  def new
    @production = Production.new
  end

  def create
    @production = Production.new(params[:production])
    if @production.save
      format.html { redirect_to(@production, :notice => "Production successfully created!") }
      format.xml  { render :xml => @production, :status => :created, :location => @production }
    else
      format.html { redirect_to new_production_path(:current) }
      format.xml  { render :xml => @production.errors, :status => :unprocessable_entity }
    end
  end  


  
  def show
    @production = Production.find(params[:id])
  end
end
