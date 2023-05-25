class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
