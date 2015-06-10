class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @conversations = current_user.mailbox.conversations
  end

  def create
    conv  = current_user.mailbox.conversations.where(
      id: params[:conversation_id]
    ).first
    receipt = current_user.reply_to_conversation(conv, params[:message])
    message = receipt.message
    conv.participants.delete(current_user)
    recipient = conv.participants.first

    $redis.publish('message', {
      recipient_id: recipient.id,
      recipient_name: recipient.full_name,
      sender_id: message.sender_id,
      sender_name: message.sender.full_name,
      body: message.body,
      created_at: message.created_at,
      id: message.id
    }.to_json )
    # Pusher.trigger("conversation_#{conv.id}", 'new-message',
    # {
    #   sender_id: message.sender_id,
    #   sender_name: message.sender.full_name,
    #   body: message.body
    # })

    respond_to do |format|
      format.json do
        render json: message
      end
    end
  end

  def show
    message = Mailboxer::Message.find(params[:id])

    respond_to do |format|
      format.json do
        render json: message
      end
    end
  end
end
