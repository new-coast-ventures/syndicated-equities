# ================================================
# RUBY->CONTROLLER->NOTESCONTROLLER ==============
# ================================================
class NotesController < ApplicationController
  before_action :authenticate_user! unless Rails.env.development?

  # ----------------------------------------------
  # INDEX ----------------------------------------
  # ----------------------------------------------

  def index
    @notes = Note.all
  end

  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @note = Note.find(params[:id])
  end

  # ----------------------------------------------
  # NEW ------------------------------------------
  # ----------------------------------------------

  def new
    @note = Note.new
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @note = Note.find(params[:id])
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to :back, notice: 'Note saved'
    else
      redirect_to :back, alert: "There was an issue saving this note. #{@note.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(note_params)
      redirect_to :back, notice: 'Note saved'
    else
      redirect_to :back, alert: "There was an issue saving this note. #{@note.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # DESTROY --------------------------------------
  # ----------------------------------------------

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      redirect_to :back, notice: 'Note removed'
    else
      redirect_to :back, alert: "There was an issue removing this note. #{@note.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def note_params
    params.require(:note).permit(:deal_id, :title, :content)
  end
end
