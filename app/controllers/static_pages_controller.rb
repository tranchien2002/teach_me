class StaticPagesController < ApplicationController
  before_action :search_params
  def home
    @requests = Request.all.page(params[:page]).per(Settings.request.per)
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
