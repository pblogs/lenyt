class AddUnitTokenInAssets < ActiveRecord::Migration
  def change
    add_column :assets, :unit_token, :string
    add_column :assets, :is_main, :boolean, default: false
  end
end
