class AddAttachmentsToNotes < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.attachment :document
    end
  end
end
