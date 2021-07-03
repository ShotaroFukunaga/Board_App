class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  def show;end

  def edit;end

  def update
    if @user.update(profile_params)
      redirect_to profile_path, success: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_update', item: User.model_name.human)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
  
  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :avatar_cache)
  end
end
