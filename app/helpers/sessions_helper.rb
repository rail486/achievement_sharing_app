######################################################################
### File Name           : sessions_helper.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : 利用者のログイン状態やログイン情報記憶に関する
###                       処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

module SessionsHelper
######################################################################
### Method Name         : log_in
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者をログインさせる．
######################################################################
  def log_in(user)
    session[:user_id] = user.id
  end

######################################################################
### Method Name         : remember
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者のログイン情報を記憶する．
######################################################################
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

######################################################################
### Method Name         : current_user
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ログイン中の利用者の情報を返す．
###                       ログイン中の利用者がいない場合，正しい
###                       クッキー情報が存在すれば，ログインさせる．
######################################################################
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

######################################################################
### Method Name         : logged_in?
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ログイン中の利用者がいればTrue，
###                       いなければFalseを返す．
######################################################################
  def logged_in?
    !current_user.nil?
  end

######################################################################
### Method Name         : forget
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : クッキー情報を削除する．
######################################################################
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

######################################################################
### Method Name         : log_out
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者をログアウトさせる．
######################################################################
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

######################################################################
### Method Name         : redirect_back_or
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : URLが保存されている場合，そのURLに移動する．
###                       保存されていない場合，引数のURLに移動する．
######################################################################
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

######################################################################
### Method Name         : store_location
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : HTTPリクエストがGETメソッドの場合，URLを保存する．
######################################################################
  def store_location
    if request.get?
      session[:forwarding_url] = request.original_url
    end
  end

######################################################################
### Method Name         : logged_in_user
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ログイン中の利用者がいない場合，
###                       ログイン画面に移動する．
######################################################################
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to "/login"
    end
  end
end
