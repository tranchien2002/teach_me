class NotificationApplyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_apply_channel"
    stream_from "notification_apply_channel_user_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
