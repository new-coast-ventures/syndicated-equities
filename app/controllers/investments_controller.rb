# ================================================
# RUBY->CONTROLLER->INVESTMENTSCONTROLLER ========
# ================================================
class InvestmentsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @investments = Investment.all
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @investment = Investment.find(params[:id])
  end

  # ----------------------------------------------
  # NEW ------------------------------------------
  # ----------------------------------------------

  def new
    @investment = Investment.new
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @investment = Investment.find(params[:id])
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @investment = Investment.new(investment_params)
    if @investment.save
      redirect_to :back, notice: 'Investment saved'
    else
      redirect_to :back, alert: "There was an issue saving this investment. #{@investment.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @investment = Investment.find(params[:id])
    if @investment.update_attributes(investment_params)
      redirect_to :back, notice: 'Investment saved'
    else
      redirect_to :back, alert: "There was an issue saving this investment. #{@investment.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # DESTROY --------------------------------------
  # ----------------------------------------------

  def destroy
    @investment = Investment.find(params[:id])
    if @investment.destroy
      redirect_to :back, notice: 'Investment removed'
    else
      redirect_to :back, alert: "There was an issue removing this investment. #{@investment.errors.full_messages.to_sentence}"
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
