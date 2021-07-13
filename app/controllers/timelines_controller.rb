######################################################################
### File Name           : timelines_controller.rb
### Version             : V1.0
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Purpose             : タイムラインに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 木澤 航輝, 2021.07.06

class TimelinesController < ApplicationController
  before_action :logged_in_user

######################################################################
### Method Name         : index
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : タイムラインを表示するための準備を行う．
######################################################################
  def index
    @tasks = current_user.filter.where(share: true).where(date: Date.today-7..Date.today+7).order(date: "DESC")
  end
end
