class StaticPagesController < ApplicationController
  before_action :search_params
  def home
    @hot_topics = Request.hot_topic
    if params[:topic]
      @requests = Request.request_by_topic(params[:topic]).page(params[:page]).per(Settings.request.per)
    else
      @requests = Request.request_applying.page(params[:page]).per(Settings.request.per)
    end
    respond_to do |format|
      format.js
      format.html
    end
    if params[:q]
      @users = @q.result.includes(:requests).page(params[:page]).per(Settings.request.per)
      if @users.present?
        render "users/index"
        return
      else
        flash[:warning] = t("controllers.static_pages.warning")
      end
    end
  end

  private
  def search_params
    @q = User.ransack params[:q]
  end
end
