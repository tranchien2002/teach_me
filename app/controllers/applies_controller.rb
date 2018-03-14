class AppliesController < ApplicationController
  before_action :authenticate_user!
  def create
    apply = current_user.applies.build request_id: params[:request_id]
    if apply.save
      @applier = current_user
    else
      redirect_to request.referrer || root_url
      flash[:danger] = t "controllers.applies.create.incorrect"
    end
    respond_to do |format|
      format.js
    end
  end
end
