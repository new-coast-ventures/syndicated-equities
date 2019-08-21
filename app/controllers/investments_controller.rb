# ================================================
# RUBY->CONTROLLER->INVESTMENTSCONTROLLER ========
# ================================================
class InvestmentsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------
  def index 
    @investments = Investment.all
  end

  def show
    @investment = Investment.find_by(id: params[:id])
    @property_investments = Property.find(@investment&.deal&.property&.id).investments.where(user_id: current_user.id)
    if @investment && current_user && @investment.investor == current_user || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  rescue => e  
    flash[:alert] = 'Sorry, that investment is not available.'
    redirect_to main_app.root_path
  end

  def import
    begin
      Investment.import(params[:file], params[:id])
      flash[:notice] = 'Investments have been successfully imported.'
      redirect_to property_path(params[:id])
    rescue
      flash[:alert] = "Invalid file format."
      redirect_to property_path(params[:id])
    end
  end
end
