class AddInvestmentEmail < ActiveRecord::Migration[5.1]
  def change
    change_table :investments do |t|
      t.string :investor_email
    end
  end
end
