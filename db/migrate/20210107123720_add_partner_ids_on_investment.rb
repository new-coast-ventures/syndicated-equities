class AddPartnerIdsOnInvestment < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :partner_id, :string
  end
end
