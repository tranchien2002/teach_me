class AppliesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def create
    apply = current_user.applies.build request_id: params[:request_id]
    if apply.save
      @applier = current_user
      current_request = apply.request
      noti = current_user.send_notifications.create(event: t("views.requests.notifications.apply") + current_request.header, receiver_id: current_request.user_id, object_type: "request", object_id: current_request.id)
      ActionCable.server.broadcast "notification_apply_channel", applier: render_applier(current_user, current_request.id),
                                   request_id: current_request.id,
                                   notification: render_notification(noti),
                                   owner_request: current_request.user_id
    else
      flash[:danger] = apply.errors.full_messages[0]
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  def destroy
    apply = Apply.find_by(id: params[:id])
    if apply.nil? || current_user.id != apply.user_id
      flash[:danger] = t "controllers.applies.destroy.delete_denied"
      redirect_to request.referrer || root_url
    else
      current_request = apply.request
      noti = current_user.send_notifications.create(event: t("views.requests.notifications.delete") + current_request.header, receiver_id: current_request.user_id, object_type: "request", object_id: current_request.id)
      if apply.destroy!
        ActionCable.server.broadcast "notification_apply_channel", applier_destroy: apply.user_id,
                                     request_id: current_request.id,notification: render_notification(noti),
                                     owner_request: current_request.user_id
      end
    end
  end

  private
  def render_notification notification
    render_to_string partial: "notifications/notification", locals: {notification: notification}
  end

  def render_applier applier, request_id
    render_to_string partial: "users/applier", locals: {applier: applier, request_id: request_id}
  end

end
