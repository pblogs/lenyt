class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    remove_column :products, :category
    add_column :products, :category_id, :integer

    Category.create(name: 'Canon')
    Category.create(name: 'Nikon')
    Category.create(name: 'Polaroid')
    Category.create(name: 'Sony')
  end
end
