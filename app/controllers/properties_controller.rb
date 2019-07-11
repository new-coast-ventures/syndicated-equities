class PropertiesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @properties = Property.all
    @property = Property.new
    
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

  def create
    # create property
    property = Property.new(property_params)
    property.status = "active"
    property.save

    # create address
    address = Address.new(address_params)
    address.addressable_id = property.id
    address.save

    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:name, :closing_date, :nickname, :status)
  end

  def address_params
    params.require(:property).permit(:line1, :city, :state, :zip, :country)
  end
end