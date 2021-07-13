######################################################################
### File Name           : application_helper.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : アプリケーション全体で使用するヘルパーを定義する．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

module ApplicationHelper
######################################################################
### Method Name         : full_title
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数が存在しない場合，
###                       "Achievement Sharing App"を返す．
###                       引数が存在する場合，
###                       "引数 | Achievement Sharing App"を返す．
######################################################################
  def full_title(page_title = "")
    base_title = "Achievement Sharing App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
