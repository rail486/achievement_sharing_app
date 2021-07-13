######################################################################
### File Name           : sessions_controller.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : 利用者のログイン，ログアウトに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

class SessionsController < ApplicationController
######################################################################
### Method Name         : new
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ログイン画面を表示するための準備を行う．
######################################################################
  def new
  end

######################################################################
### Method Name         : create
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者IDとパスワードの組み合わせが正しければ
###                       ログインさせ，カレンダー画面に移動する．
######################################################################
  def create
    @user = User.find_by(uid: params[:session][:uid])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      if params[:session][:remember_me] == "1"
        remember(@user)
      else
        forget(@user)
      end
      redirect_back_or "/calendar"
    else
      flash.now[:danger] = 'IDまたはパスワードが正しくありません'
      render 'new'
    end
  end

######################################################################
### Method Name         : destroy
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者がログイン中の場合，ログアウトさせ，
###                       トップページに移動する．
######################################################################
  def destroy
    if logged_in?
      log_out
    end
    redirect_to "/"
  end
end
