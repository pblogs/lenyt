module Api
  class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_conversation, only: [:show]
    respond_to :json

    def index
      @conversations = current_user.mailbox.conversations
      render json: @conversations
    end

    def show
       render json: @conversation
    end

    private

    def load_conversation
      @conversation = current_user.mailbox.conversations.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        return render json: { status: 'not found' }
    end
  end
end
