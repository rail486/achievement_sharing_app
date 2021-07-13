######################################################################
### File Name           : application_controller.rb
### Version             : V1.0
### Designer            : 西山 雄翔
### Date                : 2021.07.06
### Purpose             : 処理部全体で共通して使用する処理を定義する．
###
######################################################################
### Revision :
### V1.0 : 西山 雄翔, 2021.07.06

class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :danger
end
