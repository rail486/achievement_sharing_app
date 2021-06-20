class TasklistsController < ApplicationController
  #
  def index
    session[:date] = params[:format]

    @unshared_tasks = current_user.tasks.where(date: session[:date]).where(share: false)
    @shared_tasks = current_user.tasks.where(date: session[:date]).where(share: true)
    #@unshared_tasks = Task.where(userid: current_user.userid).where(date: session[:date]).where(share: false)
    #@shared_tasks = Task.where(userid: current_user.userid).where(date: session[:date]).where(share: true)

  end
end
