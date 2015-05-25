class AddMapsColumnsToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :meet_location
    add_column :products, :address, :string
    add_column :products, :latitude,  :float #you can change the name, see wiki
    add_column :products, :longitude, :float #you can change the name, see wiki
    add_column :products, :gmaps, :boolean #not mandatory, see wiki
                                          # jquery address picker fields
    add_column :products, :postal_code, :string
    add_column :products, :country, :string
    add_column :products, :locality, :string
    add_column :products, :administrative_area_level_2, :string
    add_column :products, :administrative_area_level_1, :string
    add_column :products, :location_type, :string
  end
end
