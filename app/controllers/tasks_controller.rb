######################################################################
### File Name           : tasks_controller.rb
### Version             : V1.0
### Designer            : 城田 陽亮，西山 雄翔
### Date                : 2021.07.06
### Purpose             : タスクに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 城田 陽亮，西山 雄翔, 2021.07.06

class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :exist_task,    only: [:edit, :update, :destroy, :finish, :share, :unshare]
  before_action :correct_owner, only: [:edit, :update, :destroy, :finish, :share, :unshare]
  before_action :correct_date,  only: [:index, :tasklist, :new]

######################################################################
### Method Name         : tasklist
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスク一覧を表示するための準備を行う．
######################################################################
  def tasklist
    session[:date] = params[:format]
    @tasks = current_user.tasks.where(date: session[:date]).order(:id)
  end

######################################################################
### Method Name         : index
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスク編集一覧を表示するための準備を行う．
######################################################################
  def index
    session[:date] = params[:format]
    @tasks = current_user.tasks.where(date: session[:date]).order(:id)
  end

######################################################################
### Method Name         : new
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : タスク追加画面を表示するための準備を行う．
######################################################################
  def new
    session[:date] = params[:format]
    @task = current_user.tasks.build()
  end

######################################################################
### Method Name         : create
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : タスクを追加し，タスク編集一覧に移動する．
######################################################################
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

######################################################################
### Method Name         : edit
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : タスク個別編集画面を表示するための準備を行う．
######################################################################
  def edit
    @task = Task.find(params[:id])
  end

######################################################################
### Method Name         : update
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : タスクを変更し，タスク編集一覧に移動する．
######################################################################
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を更新しました"
    else
      flash.now[:danger] = "タスク#{@task.content}を更新できませんでした"
      render 'edit'
    end
  end

######################################################################
### Method Name         : destroy
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスクを削除する．
######################################################################
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を削除しました"
  end

######################################################################
### Method Name         : finish
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスクを完了する．
######################################################################
  def finish
    @task = Task.find(params[:id])
    @task.finish_task
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を完了しました"
  end

######################################################################
### Method Name         : share
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスクを共有する．
######################################################################
  def share
    @task = Task.find(params[:id])
    @task.share_task
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}を共有しました"
  end

######################################################################
### Method Name         : unshare
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : タスクの共有を解除する．
######################################################################
  def unshare
    @task = Task.find(params[:id])
    @task.unshare_task
    redirect_to tasks_path(session[:date]), success: "タスク#{@task.content}の共有をやめました"
  end

  private

######################################################################
### Method Name         : task_params
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : 不正なカラムデータを無視する．
###                       許可されたカラム
###                       -タスク内容
###                       -達成度
######################################################################
    def task_params
      params.require(:task).permit(:content, :achievement)
    end

######################################################################
### Method Name         : exist_task
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : 対象のタスクが存在しない場合，
###                       カレンダー画面に移動する．
######################################################################
    def exist_task
      begin
        @task = Task.find(params[:id])
      rescue
        redirect_to "/calendar"
      end
    end

######################################################################
### Method Name         : correct_owner
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : 対象のタスクの所有者とログイン中の利用者が
###                       一致しない場合，カレンダー画面に移動する．
######################################################################
    def correct_owner
      @task = Task.find(params[:id])
      @user = @task.user
      redirect_to "/calendar" unless @user == current_user
    end

######################################################################
### Method Name         : correct_date
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : パラメータが日付の形式ではない場合，
###                       カレンダー画面に移動する．
######################################################################
    def correct_date
      redirect_to "/calendar" unless date_valid?(params[:format])
    end

######################################################################
### Method Name         : date_valid?
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Function            : 引数の文字列が日付の形式の場合はTrueを返し，
###                       異なる場合はFalseを返す．
######################################################################
    def date_valid?(str)
      !! Date.parse(str) rescue false
    end
end
