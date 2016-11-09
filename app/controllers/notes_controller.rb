# ================================================
# RUBY->CONTROLLER->NOTESCONTROLLER ==============
# ================================================
class NotesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @note = Note.find(params[:id])
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def note_params
    params.require(:note).permit(:deal_id, :title, :content)
  end
end
