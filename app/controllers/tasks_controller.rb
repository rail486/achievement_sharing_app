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
