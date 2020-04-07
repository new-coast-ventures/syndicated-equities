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

  def update
    begin
      note = Note.find(params[:id])
      note.update!(note_params)
    rescue => e 
      flash[:alert] = 'We were unable to update the Note. Please try again.'
      puts "%%%%%%%%%% #{e} %%%%%%%%%%%%%%%%%"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Note.find(params['id']).destroy
    
    redirect_back(fallback_location: root_path)
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------
  
  def show
    @note = Note.find_by(id: params[:id])
    if @note && current_user && @note.deal.investors.include?(current_user) || current_user.admin? || current_user.employee
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content, :property_id, :note_preview)
  end

end
