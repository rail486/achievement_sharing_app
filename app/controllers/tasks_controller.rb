class TasksController < ApplicationController
  #
  def index
    @unshared_tasks = current_user.tasks.where(date: session[:date]).where(share: false)
    @shared_tasks = current_user.tasks.where(date: session[:date]).where(share: true)
  end

  def tasklist
    session[:date] = params[:format]
    @unshared_tasks = current_user.tasks.where(date: session[:date]).where(share: false)
    @shared_tasks = current_user.tasks.where(date: session[:date]).where(share: true)
  end

  def new
    @task = current_user.tasks.build()
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.date = session[:date]
    @task.share = false
    if @task.save
      redirect_to tasks_path(session[:date])
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path(session[:date])
    else
      render 'edit'
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path(session[:date]), primary: "タスク#{@task.content}を削除しました"
  end

  def finish
    @task = Task.find(params[:id])
    @task.update_attribute(:achievement, 100)
    redirect_to tasks_path(session[:date]), primary: "タスク#{@task.content}を完了しました"
  end

  def share
    @task = Task.find(params[:id])
    @task.update_attribute(:share, true)
    redirect_to tasks_path(session[:date]), primary: "タスク#{@task.content}を共有しました"
  end

  def unshare
    @task = Task.find(params[:id])
    @task.update_attribute(:share, false)
    redirect_to tasks_path(session[:date]), primary: "タスク#{@task.content}の共有をやめました"
  end

  private

  def task_params
    params.require(:task).permit(:content, :achievement)
  end

end
