class GrossDistributionsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  
  def show
    @investment = Investment.find(params[:id])
    @gross_distributions = @investment.gross_distributions
    @property = @investment.deal.property
    @gross_distribution = GrossDistribution.new()
  end

  private
  
  def gross_distribution_params
    params.require(:gross_distribution).permit(:investment_id, :amount, :distribution_date, :description)
  end
end