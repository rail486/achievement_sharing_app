######################################################################
### File Name           : calendars_controller.rb
### Version             : V1.0
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Purpose             : カレンダーに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 城田 陽亮, 2021.07.06

class CalendarsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_date

######################################################################
### Method Name         : index
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : カレンダー画面を表示するための準備を行う．
######################################################################
  def index
  end

  private

######################################################################
### Method Name         : correct_date
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : パラメータが日付の形式ではない場合，
###                       カレンダー画面に移動する．
######################################################################
    def correct_date
      if params[:start_date].present?
        redirect_to "/calendar" unless date_valid?(params[:start_date])
      end
    end

######################################################################
### Method Name         : date_valid?
### Designer            : 城田 陽亮
### Date                : 2021.07.06
### Function            : 引数の文字列が日付の形式の場合はTrueを返し，
###                       異なる場合はFalseを返す．
######################################################################
    def date_valid?(str)
      !! Date.parse(str) rescue false
    end
end
