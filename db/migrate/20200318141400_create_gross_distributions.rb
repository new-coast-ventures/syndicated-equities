class CreateGrossDistributions < ActiveRecord::Migration[5.2]
  def change
    unless table_exists? :gross_distributions
      create_table :gross_distributions do |t|
        t.references :investment, foreign_key: true
        t.string :amount
        t.string :distribution_date
        t.string :description

        t.timestamps
      end
    end
  end
end
