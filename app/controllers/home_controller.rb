# ================================================
# RUBY->CONTROLLER->HOMECONTROLLER ==============
# ================================================
class HomeController < ApplicationController

  before_action :authenticate_user!, only: %w(index)

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    redirect_to forms_path
  end

  def terms
  end
end
