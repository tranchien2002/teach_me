class AppliesController < ApplicationController
  before_action :authenticate_user!
  def create
    apply = current_user.applies.build request_id: params[:request_id]
    if apply.save
      @applier = current_user
      current_request = apply.request
      noti = current_user.send_notifications.create(event: "Đã ứng tuyển " + current_request.header, receiver_id: current_request.user_id)
      ActionCable.server.broadcast "notification_apply_channel", applier: render_applier(current_user),
                                   request_id: current_request.id,
                                   notification: render_notification(noti),
                                   owner_request: current_request.user_id
    else
      redirect_to request.referrer || root_url
      flash[:danger] = t "controllers.applies.create.incorrect"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def render_notification notification
    render_to_string partial: "notifications/notification", locals: {notification: notification}
  end

  def render_applier applier
    render_to_string partial: "users/applier", locals: {applier: applier}
  end
end
