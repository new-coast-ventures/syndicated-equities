# ================================================
# RUBY->CONTROLLER->FORMSCONTROLLER ==============
# ================================================
class FormsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def index
    @doc = Form.new
    @forms = Form.where(property_id: nil)
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
    params.require(:form).permit(:title, :property_id, :document)
  end
end
