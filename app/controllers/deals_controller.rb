# ================================================
# RUBY->CONTROLLER->DEALSCONTROLLER ==============
# ================================================
class DealsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def deal_params
    params.require(:deal).permit(:title, :description, :date)
  end

end
