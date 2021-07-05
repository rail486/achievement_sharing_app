class TopPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to "/calendar"
    end
  end
end
