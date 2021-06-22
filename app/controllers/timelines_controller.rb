class TimelinesController < ApplicationController
  def index
    @tasks = current_user.feed.where(share, true).paginate(page: params[:page])
  end
end
