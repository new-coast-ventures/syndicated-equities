class PropertiesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @properties = Property.all
    
    if params[:search] && !params[:search].blank?
      @properties = Property.search(params[:search]).order("created_at DESC")
    end
    
    if params[:status] && !params[:status].blank?
      @properties = Property.filter(params[:status]).order("created_at DESC")
    end

    if @properties && current_user
      render 'index'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  def show
    @property = Property.find(params[:id])
    if @property && current_user
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end
end