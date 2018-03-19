class Admin::DiplomasController < ActionController::Base
  before_action :load_diploma, only: [:index, :update, :destroy]
  before_action :verify_admin!

  def index
    @diplomas = Diploma.all.page(params[:page]).per(Settings.request.per)
  end

  def update
    if @diploma.update_attributes diploma_params
      @diplomas_pending = Diploma.verify(false).page(params[:page]).per(Settings.request.per)
      @diplomas_approved = Diploma.verify(true).page(params[:page]).per(Settings.request.per)
      flash[:success] = t "views.admin.diplomas.index.update_success"
    else
      flash[:danger] = t "views.admin.diplomas.index.update_fail"
    end
    redirect_to admin_diplomas_path
  end

  def destroy
    if @diploma.destroy
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
    @diplomas_pending = Diploma.verify(false).page(params[:page]).per(Settings.request.per)
    @diplomas_approved = Diploma.verify(true).page(params[:page]).per(Settings.request.per)
    return if @diploma
    redirect_to root_path
  end

  def diploma_params
    params.require(:diploma).permit :certification, :verify
  end

  def verify_admin!
    return if current_user.admin?
    redirect_to root_path
  end
end
