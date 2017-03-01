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
end
