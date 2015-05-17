class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :category
      t.integer :price_per_day, default: 0
      t.integer :total_value, default: 0
      t.text :details
      t.boolean :is_available, default: false
      t.date :available_at
      t.date :end_at
      t.string :meet_location
      t.timestamps
    end
  end
end
