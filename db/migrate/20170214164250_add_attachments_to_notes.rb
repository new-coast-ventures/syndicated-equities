class AddAttachmentsToNotes < ActiveRecord::Migration[5.1]
  def change
    change_table :notes do |t|
      t.attachment :document
    end
  end
end
