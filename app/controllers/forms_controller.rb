# ================================================
# RUBY->CONTROLLER->FORMSCONTROLLER ==============
# ================================================
class FormsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @form = Form.find(params[:id])
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def form_params
    params.require(:form).permit(:title, :description, :date)
  end
end
