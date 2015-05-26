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

    respond_to do |format|
      format.json do
        render json: receipt.message
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
