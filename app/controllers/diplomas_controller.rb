class DiplomasController < ApplicationController
  before_action :load_diploma, except: [:index, :new, :create, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @diplomas = Diploma.all.page(params[:page]).per(Settings.request.per)
  end

  def new
    @diploma = Diploma.new
  end

  def create
    @diploma = current_user.diplomas.build diploma_params
    @diploma.user_id = current_user.id
    if @diploma.save
      @diplomas_pending = current_user.diplomas.verify(false).page(params[:page]).per(Settings.request.per)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @diploma = Diploma.find_by id: params[:id]
    if @diploma.destroy
      @diplomas = current_user.diplomas.page(params[:page]).per(Settings.request.per)
      render json: {
      status: :success,
      content: render_to_string(partial: "diplomas/diploma",
        locals: {diplomas: @diplomas})
      }
    else
      render json: {
        status: :error
      }
    end
  end

  private

  def load_diploma
    @diploma = Diploma.find_by id: params[:id]
    return if @diploma
    flash[:danger] = t "controllers.diploma.diploma_load_fail"
    redirect_to root_path
  end

  def diploma_params
    params.require(:diploma).permit :certification, :demonstrate
  end
end
