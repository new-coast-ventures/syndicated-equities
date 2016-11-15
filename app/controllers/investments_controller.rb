# ================================================
# RUBY->CONTROLLER->INVESTMENTSCONTROLLER ========
# ================================================
class InvestmentsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @investment = Investment.find_by(id: params[:id])
    if @investment && @investment.investor == current_user || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def investment_params
    params.require(:investment).permit(:user_id, :deal_id, :amount_invested, :invested_on)
  end
end
