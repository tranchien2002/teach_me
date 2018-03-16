class StaticPagesController < ApplicationController
  before_action :search_params
  def home
    if params[:q]
      @users = @q.result.includes(:requests).page(params[:page]).per(Settings.request.per)
      if @users.present?
        return
        render "users/index"
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
