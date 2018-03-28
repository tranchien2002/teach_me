class NotificationConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_conversation_channel"
    stream_from "notification_conversation_channel_user_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
