class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :job_title
      t.integer :salary
      t.string :phone_number
      t.date :start_date

      t.timestamps
    end
  end
end
