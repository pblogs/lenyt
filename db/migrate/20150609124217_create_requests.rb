class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :renter_id
      t.integer :rentee_id
      t.integer :product_id
      t.string :amount, default: 0
      t.date :rent_from_date
      t.date :rent_to_date

      t.timestamps null: false
    end
  end
end
