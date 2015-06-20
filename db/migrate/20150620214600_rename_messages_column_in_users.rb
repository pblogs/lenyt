class RenameMessagesColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :messages, :messages_notifcations
    rename_column :users, :newsletter, :newsletter_notifcations
  end
end
