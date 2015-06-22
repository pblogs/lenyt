class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state

      t.timestamps null: false
    end

    CS.states(:ca).each do |s|
      CS.cities(s[0], :ca).each do |c|
        City.create(name: c, state: s[0])
      end
    end
  end
end
