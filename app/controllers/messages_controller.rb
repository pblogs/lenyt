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
    Pusher.trigger("conversation_#{conv.id}", 'new-message',
    {
      sender_id: message.sender_id,
      sender_name: message.sender.full_name,
      body: message.body
    })

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
