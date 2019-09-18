class AddAmountCentsToInvestments < ActiveRecord::Migration[5.1]
  def change
    add_monetize :investments, :amount, amount: { null: true, default: nil }
  end
end
