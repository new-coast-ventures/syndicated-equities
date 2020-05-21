class GrossDistributionsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?
  before_action :check_master_admin
  
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

  def import_headers
    @import_file = params[:file].path
    GrossDistribution.create_temp_xlsx(@import_file)
    @property_id = params[:id]
    @gross_distribution = GrossDistribution.new
    @headers = GrossDistribution.pull_headers(@import_file)
    @import_fields = ['investor_email', 'investor_entity', 'amount', 'distribution_date']
    
    render 'properties/import_distribution_headers'
  rescue => e  
    puts "ERROR:: #{e}"
    flash[:alert] = "Invalid file format, please modify or import a different file."
    redirect_to property_path(params[:id]) 
  end

  def import
    begin
      invalid_entries = GrossDistribution.import(params[:property_id], params[:import_file], params[:post])
      property_id = params[:property_id]
      file = "lib/imports/#{params[:import_file].split("/")[-1]}"
      
      File.delete(file) if File.exist?(file)
      if !invalid_entries[:invalid_entities].blank? || !invalid_entries[:invalid_emails].blank?
        notice = ""
        
        if !invalid_entries[:invalid_entities].blank?
          notice += "These Entities failed to load: <br> #{invalid_entries[:invalid_entities].join("<br>")}"
        end
        
        if !invalid_entries[:invalid_emails].blank?
          notice += "<br> Emails #{invalid_entries[:invalid_emails].join("<br>")} do not belong to any investment"
        end
        
        flash[:notice] = notice.html_safe
      else
        flash[:notice] = 'Distributions have been uploaded successfully.'
      end
      redirect_to property_path(params[:property_id])
    rescue => e  
      puts "ERROR:: #{e}"
      # flash[:notice] = "Investments have been imported. If something seems w"
      redirect_to property_path(params[:property_id])
    end
  end

  private
  
  def gross_distribution_params
    params.require(:gross_distribution).permit(:investment_id, :amount, :distribution_date, :description)
  end
end