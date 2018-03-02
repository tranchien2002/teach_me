class RequestsController < ApplicationController
  def new
    @request_user = Request.new
  end

  def create
    request_user = current_user.requests.new request_params
    if request_user.save
      flash[:success] = t "controllers.requests.create.success"
      redirect_to root_url
    else
      redirect_to request.referrer
      flash[:danger] = t "controllers.requests.create.form_fail"
    end
  end

  private

  def request_params
    params.require(:request).permit(:topic, :content, :header, :bill)
  end
end
