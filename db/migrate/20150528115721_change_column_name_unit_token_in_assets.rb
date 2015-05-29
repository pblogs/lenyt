class ChangeColumnNameUnitTokenInAssets < ActiveRecord::Migration
  def change
    rename_column :assets, :unit_token, :unique_token
  end
end
