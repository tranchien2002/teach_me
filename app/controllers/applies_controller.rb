class AppliesController < ApplicationController
  before_action :authenticate_user!
  def create
    apply = current_user.applies.build request_id: params[:request_id]
    if apply.save
      @applier = current_user
      ActionCable.server.broadcast "notification_apply_channel", applier: render_applier(current_user),
                                   request_id: apply.request.id
      # ActionCable.server.broadcast "notification_apply_channel_user_#{apply.request.user_id}", notification:
      #     render_notification(Notification.create(event: "Đã có người apply"))
    else
      redirect_to request.referrer || root_url
      flash[:danger] = t "controllers.applies.create.incorrect"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  # def render_notification notification
  #   render partial: "notifications/notification", locals: {notification: notification}
  # end

  def render_applier applier
    render partial: "users/applier", locals: {applier: applier}
  end
end
