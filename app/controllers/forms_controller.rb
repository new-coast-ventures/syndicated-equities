# ================================================
# RUBY->CONTROLLER->FORMSCONTROLLER ==============
# ================================================
class FormsController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @forms = Form.all
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @form = Form.find(params[:id])
  end

  # ----------------------------------------------
  # NEW ------------------------------------------
  # ----------------------------------------------

  def new
    @form = Form.new
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @form = Form.find(params[:id])
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to :back, notice: 'Form saved'
    else
      redirect_to :back, alert: "There was an issue saving this form. #{@form.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @form = Form.find(params[:id])
    if @form.update_attributes(form_params)
      redirect_to :back, notice: 'Form saved'
    else
      redirect_to :back, alert: "There was an issue saving this form. #{@form.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # DESTROY --------------------------------------
  # ----------------------------------------------

  def destroy
    @form = Form.find(params[:id])
    if @form.destroy
      redirect_to :back, notice: 'Form removed'
    else
      redirect_to :back, alert: "There was an issue removing this form. #{@form.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def form_params
    params.require(:form).permit(:title, :description, :date)
  end
end
