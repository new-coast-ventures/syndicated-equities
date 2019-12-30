class AddNotePreviewToNote < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :note_preview, :string
  end
end
