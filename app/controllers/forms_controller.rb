# ================================================
# RUBY->CONTROLLER->FORMSCONTROLLER ==============
# ================================================
class FormsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def index
    @forms = Form.where(generic: true)
  end

  def download
    if form = Form.find_by(params[:id])
      redirect_to form.document.expiring_url(10)
    end
  end
end
