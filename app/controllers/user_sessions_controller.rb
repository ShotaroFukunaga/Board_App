class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to posts_path, success: t('.success')
      #flash[:notice] = 'ログインしました'<-通常の書き方
    else
      flash.now[:danger] = t('.fail')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.success')
  end
end
