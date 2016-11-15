# ================================================
# RUBY->CONTROLLER->NOTESCONTROLLER ==============
# ================================================
class NotesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @note = Note.find_by(id: params[:id])
    if @note && @note.deal.investors.include?(current_user) || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end
end
