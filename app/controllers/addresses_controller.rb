# ================================================
# RUBY->CONTROLLER->ADDRESSESCONTROLLER =========
# ================================================
class AddressesController < ApplicationController
  before_action :authenticate_user!

  # ----------------------------------------------
  # PRIVATE ---------------------------------------
  # ----------------------------------------------

  private

  def address_params
    params.require(:address).permit(:user_id, :line1, :line2, :city, :state, :zip)
  end
end
