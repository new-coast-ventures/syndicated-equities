# ================================================
# RUBY->CONTROLLER->ADDRESSES-CONTROLLER =========
# ================================================
class AddressesController < ApplicationController
  before_action :authenticate_user!

  # ----------------------------------------------
  # NEW ------------------------------------------
  # ----------------------------------------------

  def new
    @address = Address.new
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @address = Address.find(params[:id])
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @address = Address.new(params[:address])
    if @address.save
      redirect_to :back, notice: 'Address saved'
    else
      redirect_to :back, alert: "There was an issue saving this address. #{@address.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      redirect_to :back, notice: 'Address saved'
    else
      redirect_to :back, alert: "There was an issue saving this address. #{@address.errors.full_messages.to_sentence}"
    end
  end
end
