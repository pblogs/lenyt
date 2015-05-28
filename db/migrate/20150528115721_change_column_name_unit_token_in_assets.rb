class ChangeColumnNameUnitTokenInAssets < ActiveRecord::Migration
  def change
    rename_column :assets, :unit_token, :uniq_token
  end
end
