include ActionView::Helpers::NumberHelper

# ================================================
# RUBY->CONTROLLER->FORMSCONTROLLER ==============
# ================================================
class FormsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?
  before_action :check_master_admin

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def index
    @doc = Form.new
    @forms = Form.where(property_id: nil, form_library: [nil, false]).order("created_at DESC")
    @note = Note.new
    @notes = Note.where(property_id: nil)
    user_investments = current_user&.investments
    
    @pie_data = [] 
    user_investments.each{|x| @pie_data << [x&.deal&.property&.nickname, x&.amount_invested]}
    @pie_colors = 100.times.map{"#%06x" % (rand * 0x1000000)}

    
    type_count = current_user.investment_properties.group(:property_type).count

    investment_totals = current_user.investment_properties.map { |inv| 

      inv_key = "#{inv.property_type&.humanize&.titleize} - #{type_count[inv.property_type]}"
      inv_value = "#{inv.investments.find_by_user_id(current_user.id).amount_invested}"

      {
        inv_key => inv_value
      }
    }
    
    @column_data = {}
    investment_totals.each {|z| @column_data.merge!(z) { |k, o, n| o.to_i + n.to_i }}

  end

  def form_library
    @doc = Form.new
    @forms = Form.where(form_library: true).order("created_at DESC")
  end

  def create
    form = Form.new(form_params)
    if form.save
    else
      flash[:alert] = "#{form.errors.full_messages}"
      # flash[:alert] = 'Not authorized'
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    begin
      form = Form.find(params[:id])
      form.update!(form_params)
    rescue => e 
      flash[:alert] = 'We were unable to update the Form. Please try again.'
      puts "%%%%%%%%%% #{e} %%%%%%%%%%%%%%%%%"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Form.find(params['id']).destroy
    
    redirect_back(fallback_location: root_path)
  end

  def download
    if form = Form.find_by(params[:id])
      redirect_to form.document.expiring_url(10)
    end
  end

  private

  def form_params
    params.require(:form).permit(:title, :property_id, :document, :form_library)
  end
end
