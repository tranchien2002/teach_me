class UsersController < ApplicationController
  load_and_authorize_resource param_method: :user_params

  def show
    @user = User.find_by id: params[:id]
    @diplomas_pending = @user.diplomas.verify(false).page(params[:page]).per(Settings.request.per)
    @diplomas_approved = @user.diplomas.verify(true).page(params[:page]).per(Settings.request.per)
    @diploma = Diploma.new
    return if @user
    flash[:danger] = t "controllers.users.show.danger"
    redirect_to root_url
  end

  def index
    @q = User.ransack params[:q]
    @q.sorts = "name asc" if @q.sorts.empty?
    @users = @q.result.includes(:requests).page(params[:page]).per(Settings.request.per)
  end

  def search
    render :index
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation, :avatar, :description, :adress, :sex
  end
end
