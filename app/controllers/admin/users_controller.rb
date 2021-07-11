class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show destroy edit update]
  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
  
  def show; end

  def edit; end

  def update
    if @user.update(params_user)
      redirect_to admin_users_path, success: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_update', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, success: t('defaults.message.delete', item: User.model_name.human)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :avatar_cache, :role)
  end
end
