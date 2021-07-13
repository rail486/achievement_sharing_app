######################################################################
### File Name           : top_pages_controller.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : トップページに関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

class TopPagesController < ApplicationController
######################################################################
### Method Name         : home
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : トップページを表示するための準備を行う．
######################################################################
  def home
    if logged_in?
      redirect_to "/calendar"
    end
  end
end
