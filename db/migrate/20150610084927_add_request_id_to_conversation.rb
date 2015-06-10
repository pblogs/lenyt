class AddRequestIdToConversation < ActiveRecord::Migration
  def change
    add_column :mailboxer_conversations, :request_id, :integer
  end
end
