class UsersController < ApplicationController
  load_and_authorize_resource param_method: :user_params

  def show
    @user = User.find_by params[:id]
    redirect_to root_url unless @user
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation, :avatar, :description, :adress, :sex
  end
end
