class TimelinesController < ApplicationController
  def index
    @tasks = current_user.feed.where(share, true).paginate(task: params[:task])
  end
end
