class AddNotificationsOptionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :newsletter, :boolean, default: true
    add_column :users, :messages, :boolean, default: true
  end
end
