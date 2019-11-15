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

  def edit
    @investment = Investment.find(params[:id])
  end

  def destroy
    Investment.find(params['id']).destroy
    
    redirect_back(fallback_location: root_path)
  end

  def create
    invst_params = params['investment']
    
    property_id = invst_params['property_id'].nil? ? params['property']['id'] : invst_params['property_id']
    user_id = invst_params['user_id'].nil? ? params['investor']['id'] : invst_params['user_id']
    
    deal = Deal.find_or_create_by(title: invst_params["investing_entity"], property_id: property_id)
    
    investor = User.find(user_id)

    investor_hash = {
      deal_id: deal.id,
      investor_last_name: investor.last_name,
      investor_first_name: investor.first_name,
      investor_email: investor.email,
      investing_entity:invst_params["investing_entity"]&.strip,
      investor_entity: invst_params["investor_entity"]&.strip,
      gross_distribution: invst_params["gross_distribution"]&.strip,
      amount_invested: invst_params["amount_invested"]&.strip&.to_i,
      user_id: investor.id
    }

    Investment.create! investor_hash

    redirect_back(fallback_location: root_path)
  end

  def update
    @investment = Investment.find(params[:id])
    @investment.update(investment_params)
    
    redirect_back(fallback_location: root_path)
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

  def import_headers
    @investment_file = params[:file].path
    Investment.create_temp_csv(@investment_file)
    @property_id = params[:id]
    @investment = Investment.new
    @headers = CSV.read(@investment_file, headers: true).headers << ['No Mapping', nil]
    @investment_fields = ['investor_first_name', 'investor_last_name', 'investor_email', 'investor_entity', 'investing_entity', 'amount_invested', 'gross_distribution']
    
    render 'properties/import_headers'
  rescue => e  
    puts "ERROR:: #{e}"
    flash[:alert] = "Invalid file format, please modify or import a different file."
    redirect_to property_path(params[:id]) 
  end

  def import
    begin
      Investment.import(params[:property_id], params[:investment_file], params[:post])
      property_id = params[:property_id]
      file = "lib/imports/#{params[:investment_file].split("/")[-1]}"
      mapping = params[:post]
      CSV.foreach(file, headers: true) do |row|
        deal = Deal.find_or_create_by(title: row[mapping["investing_entity"]], property_id: property_id)
        user = Investment.get_user(row, mapping)
        investor_hash = {
          deal_id: deal.id,
          investor_last_name: row[mapping["investor_last_name"]]&.strip,
          investor_first_name: row[mapping["investor_first_name"]]&.strip,
          investing_entity: row[mapping["investing_entity"]]&.strip,
          investor_entity: row[mapping["investor_entity"]]&.strip,
          gross_distribution: row[mapping["gross_distribution"]]&.strip,
          amount_invested: row[mapping["amount_invested"]]&.strip&.gsub(/\D/,'').to_i,
          user_id: user.id,
          investor_email: user.email
        }
        Investment.create! investor_hash
      end
      
      File.delete(file) if File.exist?(file)

      flash[:notice] = 'Investments have been successfully imported.'
      redirect_to property_path(params[:property_id])
    rescue => e  
      puts "ERROR:: #{e}"
      flash[:alert] = "Invalid file format."
      redirect_to property_path(params[:property_id])
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:user_id, :deal_id, :amount_invested, :invested_on, :investing_entity, :investor_email, :investor_first_name, :investor_last_name, :amount_cents, :amount_currency, :investor_entity, :gross_distribution)
  end
end
