class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(posts_path, notice: 'ウェーイ')
    else
      flash.now[:alert] = 'フー！！'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(login_path, notice: 'wei')
  end
end
