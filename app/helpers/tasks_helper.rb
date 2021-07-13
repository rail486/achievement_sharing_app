######################################################################
### File Name           : tasks_helper.rb
### Version             : V1.0
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Purpose             : ビューでも使用する，タスクに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 木澤 航輝, 2021.07.06

module TasksHelper
######################################################################
### Method Name         : achievement_average
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : 引数の日付に対応したタスクの，達成度の平均を返す．
######################################################################
  def achievement_average(date)
    @average = current_user.tasks.where(date: date).average(:achievement)
    if @average.present?
      @average.to_f.round
    end
  end
end
