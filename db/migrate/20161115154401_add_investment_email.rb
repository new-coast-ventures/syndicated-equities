class AddInvestmentEmail < ActiveRecord::Migration
  def change
    change_table :investments do |t|
      t.string :investor_email
    end
  end
end
