class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_messages

  def index
  end

  def create
    message = current_user.messages.build messages_params
    if message.save
      ActionCable.server.broadcast "conversation_channel",
                                   content: message.content,
                                   created_at: message.created_at,
                                   username: message.user.name
    else
      render :index
    end
  end

  private
  def find_messages
    @messages = Message.for_display
  end

  def messages_params
    params.require(:message).permit :content, :conversation_id
  end
end
