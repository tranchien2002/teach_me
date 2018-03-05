class UsersController < ApplicationController
  def show
    @user = User.find_by params[:id]
    redirect_to root_url unless @user
  end
end
