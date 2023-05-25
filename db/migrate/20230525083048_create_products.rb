class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :instock
      t.float :price
      t.date :date
      t.integer :sales_count, default: 0

      t.timestamps
      

    end
  end
end
