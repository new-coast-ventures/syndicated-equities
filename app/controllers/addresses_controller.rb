# ================================================
# RUBY->CONTROLLER->ADDRESSESCONTROLLER =========
# ================================================
class AddressesController < ApplicationController
  before_action :authenticate_user!

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @address = Address.new(address_params)
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
    if @address.update_attributes(address_params)
      redirect_to :back, notice: 'Address saved'
    else
      redirect_to :back, alert: "There was an issue saving this address. #{@address.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # DELETE ---------------------------------------
  # ----------------------------------------------

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to :back, notice: 'Address removed'
    else
      redirect_to :back, alert: "There was an issue removing this address. #{@address.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # PRIVATE ---------------------------------------
  # ----------------------------------------------

  private

  def address_params
    params.require(:address).permit(:user_id, :line1, :line2, :city, :state, :zip)
  end

end
