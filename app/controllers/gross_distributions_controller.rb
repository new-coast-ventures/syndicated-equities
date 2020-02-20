class GrossDistributionsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  
  def show
    @investment = Investment.find(params[:id])
    @gross_distributions = @investment.gross_distributions
    @property = @investment.deal.property
    @gross_distribution = GrossDistribution.new()
  end

  def create
    gd = GrossDistribution.create(gross_distribution_params)
    if !gd.save
      flash[:alert] = 'Something went wrong. Please try again.)'
    end
      
    redirect_back(fallback_location: root_path)
  end

  def update
    gd = GrossDistribution.find(params['id'])
    gd.update(gross_distribution_params)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    GrossDistribution.find(params['id']).destroy
    
    redirect_back(fallback_location: root_path)
  end

  private
  
  def gross_distribution_params
    params.require(:gross_distribution).permit(:investment_id, :amount, :distribution_date, :description)
  end
end