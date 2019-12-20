class PropertiesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @properties = Property.all
    @active_properties = Property.where(status: 'active')
    @property = Property.new
    
    @status = params[:status] ? params[:status] : "active"
    @properties = Property.filter(@status).order("created_at DESC") 

    if @properties && current_user
      render 'index'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  def show
    @property = Property.find(params[:id])

    @investment = Investment.new
    @note = Note.new

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

    if property.save

      # create address
      address = Address.new(address_params)
      address.addressable_id = property.id
      address.addressable_type = "Property"
      address.save
    else
      flash[:alert] = 'Something went wrong. Please try and add the property again. (rememeber the image needs to be above 600 x 600)'
    end

    redirect_to properties_path
  end

  def update
    @property = Property.find(params["id"])
    if @property
      @property.update(property_params)
    else
      puts "Property in Nil"
    end
    if @property.address
      @property&.address&.update(address_params)
    else
      address = Address.new(address_params)
      address.addressable_id = @property.id
      address.addressable_type = "Property"
      address.save
    end
    @investment = Investment.new
    render 'show'
  end

  def destroy
    property = Property.find(params['id'])
    property_name = property.name
    Deal.where(property_id: property.id).each {|deal| deal.investments.destroy_all; deal.destroy}
    property.destroy
    flash[:alert] = "#{property_name} has been successfully deleted."

    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:name, :closing_date, :nickname, :status, :avatar, :sale_date, :gross_distributions, :internal_rate_of_return, :equity_multiple, :property_type, :description)
  end

  def address_params
    params.require(:property).permit(:line1, :city, :state, :zip, :country)
  end
end