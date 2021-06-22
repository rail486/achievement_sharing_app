class TimelinesController < ApplicationController
  def index
    @tasks = Task.where(share: true)
  end
end
