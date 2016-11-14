class AddInvestingEntity < ActiveRecord::Migration
  def change
    change_table :investments do |t|
      t.string :investing_entity
    end
  end
end
