class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit_profile, :update_profile, :edit_password, :update_password, :delete_account, :destroy]
  before_action :correct_user,   only: [:edit_profile, :update_profile, :edit_password, :update_password, :delete_account, :destroy]

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

  def delete_account
  end

  def destroy
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:password])
      @user.destroy
      redirect_to "/"
    else
      flash.now[:danger] = 'パスワードが正しくありません'
      render 'delete_account'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :uid, :password, :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:name, :uid, :introduction)
    end


    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to "/login"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to "/" unless @user == current_user
    end
end
