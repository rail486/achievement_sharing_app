class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(uid: params[:session][:uid])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      if params[:session][:remember_me] == "1"
        remember(@user)
      else
        forget(@user)
      end
      redirect_back_or (@user)
    else
      flash.now[:danger] = 'IDまたはパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    if logged_in?
      log_out
    end
    redirect_to "/"
  end
end
