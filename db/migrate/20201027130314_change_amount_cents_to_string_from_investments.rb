class ChangeAmountCentsToStringFromInvestments < ActiveRecord::Migration[5.2]
  def change
    change_column :investments, :amount_cents, :string
  end
end
