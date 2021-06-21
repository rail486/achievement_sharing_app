class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def setting
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:id])
    if @user.update(profile_params)
      flash[:success] = "プロフィール変更完了"
      redirect_to "/settings"
    else
      render 'edit_profile'
    end
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(password_params)
      flash[:success] = "パスワード変更完了"
      redirect_to "/settings"
    else
      render 'edit_password'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :uid, :password, :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:name, :uid)
    end


    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
