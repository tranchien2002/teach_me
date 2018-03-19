class UsersController < ApplicationController
  load_and_authorize_resource param_method: :user_params

  def show
    @diplomas = current_user.diplomas.page(params[:page]).per(Settings.request.per)
    @diploma = Diploma.new
    @diploma.user_id = current_user.id
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controllers.users.show.danger"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation, :avatar, :description, :adress, :sex
  end
end
