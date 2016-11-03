# ================================================
# RUBY->CONTROLLER->DEALSCONTROLLER ==============
# ================================================
class DealsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @deals = Deal.all
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @deal = Deal.find(params[:id])
  end

  # ----------------------------------------------
  # NEW ------------------------------------------
  # ----------------------------------------------

  def new
    @deal = Deal.new
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @deal = Deal.find(params[:id])
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      redirect_to :back, notice: 'Deal saved'
    else
      redirect_to :back, alert: "There was an issue saving this deal. #{@deal.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @deal = Deal.find(params[:id])
    if @deal.update_attributes(deal_params)
      redirect_to :back, notice: 'Deal saved'
    else
      redirect_to :back, alert: "There was an issue saving this deal. #{@deal.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # DESTROY --------------------------------------
  # ----------------------------------------------

  def destroy
    @deal = Deal.find(params[:id])
    if @deal.destroy
      redirect_to :back, notice: 'Deal removed'
    else
      redirect_to :back, alert: "There was an issue removing this deal. #{@deal.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def deal_params
    params.require(:deal).permit(:title, :description, :date)
  end

end
