class ChangeAmountInvestedToStringFromInvestments < ActiveRecord::Migration[5.2]
  def change
    change_column :investments, :amount_invested, :string
  end
end
