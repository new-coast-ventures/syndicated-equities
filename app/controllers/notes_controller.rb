# ================================================
# RUBY->CONTROLLER->NOTESCONTROLLER ==============
# ================================================
class NotesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  def create
    note = Note.new(note_params)
    if note.save
    else
      flash[:alert] = 'Not authorized'
    end
    redirect_back(fallback_location: root_path)
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------
  
  def show
    @note = Note.find_by(id: params[:id])
    if @note && current_user && @note.deal.investors.include?(current_user) || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content, :property_id)
  end

end
