class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def show
    @conversation = Conversation.find_by id: params[:id]
    if @conversation.nil?
      redirect_to root_url
    else
      @messages = @conversation.messages
      authority_conversation! current_user, @conversation
    end
  end

  def create
    conversation = Conversation.new(newbie_id: current_user.id, expert_id: params[:applier_id], request_id: params[:request_id])
    if conversation.save
      noti = current_user.send_notifications.create(event: t("views.conversation.notification"), receiver_id: conversation.expert_id, object_type: "conversation", object_id: conversation.id)
      ActionCable.server.broadcast "notification_conversation_channel",
                                   conversation_id: conversation.id,
                                   notification: render_notification(noti),
                                   owner_conversation: conversation.expert_id
      users_in_conversation conversation
      redirect_to conversation
    else
      flash[:danger] = conversation.errors.messages[:base][0]
      redirect_to request.referrer || root_url
    end
  end

  def close
    conversation = Conversation.find_by id: params[:id]
    redirect_to request.referrer || root_url if conversation.nil?
    if close_conversation conversation
      redirect_to root_url
    end
  end

  private
  def authority_conversation! user, conversation
    if user.id != conversation.expert_id && user.id != conversation.newbie_id
      redirect_to request.referrer || root_url
    end
  end

  def users_in_conversation conversation
    User.transaction do
      conversation.newbie.update_attributes! free: false
      conversation.expert.update_attributes! free: false
    end
  end

  def close_conversation conversation
    Conversation.transaction do
      User.transaction do
        conversation.newbie.update_attributes! free: true
        conversation.expert.update_attributes! free: true
        conversation.update_attributes! done: true
      end
    end
  end

  def render_notification notification
    render_to_string partial: "notifications/notification", locals: {notification: notification}
  end

end
