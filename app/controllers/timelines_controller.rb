class TimelinesController < ApplicationController
  before_action :logged_in_user

  def index
    @tasks = current_user.filter.where(share: true).where(date: Date.today-7..Date.today+7).order(date: "DESC")
  end
end
