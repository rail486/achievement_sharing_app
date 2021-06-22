class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :danger

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to "/login"
      end
    end
end
