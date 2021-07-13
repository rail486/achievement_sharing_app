######################################################################
### File Name           : relationships_controller.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : フォロー，フォロー解除を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

class RelationshipsController < ApplicationController
  before_action :logged_in_user

######################################################################
### Method Name         : create
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : フォローする．
######################################################################
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

######################################################################
### Method Name         : destroy
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : フォロー解除する．
######################################################################
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
