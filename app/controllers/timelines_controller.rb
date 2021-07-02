class TimelinesController < ApplicationController
  before_action :logged_in_user

  def index
    @tasks = current_user.feed.where(share: true).paginate(page: params[:page])
  end
end
