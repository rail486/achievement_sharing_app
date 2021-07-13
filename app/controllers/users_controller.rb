######################################################################
### File Name           : users_controller.rb
### Version             : V1.0
### Designer            : 宮島 健太，木澤 航輝
### Date                : 2021.07.06
### Purpose             : 利用者に関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 木澤 航輝，2021.07.06

class UsersController < ApplicationController
  before_action :logged_in_user,          only: [:edit_profile, :update_profile, :edit_password, :update_password, :delete_account, :destroy, :index, :show, :setting, :following, :followers]
  before_action :exist_user_for_profile,  only: [:show]
  before_action :exist_user_for_settings, only: [:edit_profile, :update_profile, :edit_password, :update_password, :delete_account, :destroy]
  before_action :correct_user,            only: [:edit_profile, :update_profile, :edit_password, :update_password, :delete_account, :destroy]

######################################################################
### Method Name         : index
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ユーザ一覧を表示するための準備を行う．
######################################################################
  def index
    @users = User.search(params[:search]).paginate(page: params[:page], per_page: 10)
  end

######################################################################
### Method Name         : show
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : プロフィールを表示するための準備を行う．
######################################################################
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.where(share: true).order(date: "DESC").paginate(page: params[:page], per_page: 10)
  end

######################################################################
### Method Name         : new
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 新規登録画面を表示するための準備を行う．
######################################################################
  def new
    @user = User.new
  end

######################################################################
### Method Name         : create
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者登録をし，カレンダー画面に移動する．
######################################################################
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to "/calendar"
    else
      render 'new'
    end
  end

######################################################################
### Method Name         : setting
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : アカウント設定選択画面を表示するための準備を行う．
######################################################################
  def setting
  end

######################################################################
### Method Name         : edit_profile
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : プロフィール変更画面を表示するための準備を行う．
######################################################################
  def edit_profile
    @user = User.find(params[:id])
  end

######################################################################
### Method Name         : update_profile
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : プロフィールを変更し，アカウント設定選択画面に
###                       移動する．
######################################################################
  def update_profile
    @user = User.find(params[:id])
    if @user.update(profile_params)
      flash[:success] = "プロフィール変更完了"
      redirect_to "/settings"
    else
      render 'edit_profile'
    end
  end

######################################################################
### Method Name         : edit_password
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : パスワード変更画面を表示するための準備を行う．
######################################################################
  def edit_password
    @user = User.find(params[:id])
  end

######################################################################
### Method Name         : update_password
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : パスワードを変更し，アカウント設定選択画面に
###                       移動する．
######################################################################
  def update_password
    @user = User.find(params[:id])
    if @user.update(password_params)
      flash[:success] = "パスワード変更完了"
      redirect_to "/settings"
    else
      render 'edit_password'
    end
  end

######################################################################
### Method Name         : delete_account
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : アカウント削除画面を表示するための準備を行う．
######################################################################
  def delete_account
  end

######################################################################
### Method Name         : destroy
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : パスワードが正しければ利用者を削除し，
###                       アカウント削除完了画面に移動する．
######################################################################
  def destroy
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:password])
      @user.destroy
      session[:deleted] = true
      redirect_to "/deleted"
    else
      flash.now[:danger] = 'パスワードが正しくありません'
      render 'delete_account'
    end
  end

######################################################################
### Method Name         : deleted
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : アカウント削除完了画面を表示するための準備を行う．
###                       アカウントを削除した直後でなければ，
###                       トップページに移動する．
######################################################################
  def deleted
    if session[:deleted]
      session[:deleted] = nil
    else
      redirect_to "/"
    end
  end

######################################################################
### Method Name         : following
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : フォロー一覧を表示するための準備を行う．
######################################################################
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.order(:id).paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

######################################################################
### Method Name         : followers
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : フォロワー一覧を表示するための準備を行う．
######################################################################
  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.order(:id).paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  private

######################################################################
### Method Name         : user_params
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 不正なカラムデータを無視する．
###                       許可されたカラム
###                       -表示名
###                       -利用者ID
###                       -パスワード
###                       -確認用パスワード
######################################################################
    def user_params
      params.require(:user).permit(:name, :uid, :password, :password_confirmation)
    end

######################################################################
### Method Name         : profile_params
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 不正なカラムデータを無視する．
###                       許可されたカラム
###                       -表示名
###                       -利用者ID
###                       -自己紹介
######################################################################
    def profile_params
      params.require(:user).permit(:name, :uid, :introduction)
    end

######################################################################
### Method Name         : password_params
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 不正なカラムデータを無視する．
###                       許可されたカラム
###                       -パスワード
###                       -確認用パスワード
######################################################################
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

######################################################################
### Method Name         : exist_user_for_profile
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 対象の利用者が存在しない場合，ユーザ一覧に移動する．
######################################################################
    def exist_user_for_profile
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to "/users"
      end
    end

######################################################################
### Method Name         : exist_user_for_settings
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 対象の利用者が存在しない場合，
###                       アカウント設定選択画面に移動する．
######################################################################
    def exist_user_for_settings
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to "/settings"
      end
    end

######################################################################
### Method Name         : correct_user
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 対象の利用者とログイン中の利用者が一致しない場合，
###                       アカウント設定選択画面に移動する．
######################################################################
    def correct_user
      @user = User.find(params[:id])
      redirect_to "/settings" unless @user == current_user
    end
end
