class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_owner, only: [:edit, :update, :destroy, :finish, :share, :unshare]

  def index
    @tasks = current_user.tasks.where(date: session[:date])
  end

  def tasklist
    session[:date] = params[:format]
    @tasks = current_user.tasks.where(date: session[:date])
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
      redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を保存しました"
    else
      flash.now[:danger] = "タスク#{@task.content}を保存できませんでした"
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を更新しました"
    else
      flash.now[:danger] = "タスク#{@task.content}を更新できませんでした"
      render 'edit'
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を削除しました"
  end

  def finish
    @task = Task.find(params[:id])
    @task.update_attribute(:achievement, 100)
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を完了しました"
  end

  def share
    @task = Task.find(params[:id])
    @task.update_attribute(:share, true)
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を共有しました"
  end

  def unshare
    @task = Task.find(params[:id])
    @task.update_attribute(:share, false)
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}の共有をやめました"
  end

  private

    def task_params
      params.require(:task).permit(:content, :achievement)
    end

    def correct_owner
      @task = Task.find(params[:id])
      @user = @task.user
      redirect_to "/calendar" unless @user == current_user
    end
end
