class AddInvestingEntity < ActiveRecord::Migration[5.1]
  def change
    change_table :investments do |t|
      t.string :investing_entity
    end
  end
end
