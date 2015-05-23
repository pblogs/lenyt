class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    conversation = current_user.mailbox.conversations.find(params[:id])
    @messages = conversation.messages.order(created_at: :asc)

    respond_to do |format|
      format.json {
        render json: @messages
      }
     end
  end
end
