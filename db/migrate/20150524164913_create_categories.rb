class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    Category.create(name: 'Leica..')
    Category.create(name: 'Lens..')
  end
end
