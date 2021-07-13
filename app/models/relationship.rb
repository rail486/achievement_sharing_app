######################################################################
### File Name           : relationship.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : 利用者のフォロー情報に関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

######################################################################
### Column Name         : follower_id
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 空でない
######################################################################
  validates :follower_id, presence: true

######################################################################
### Column Name         : followed_id
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 空でない
######################################################################
  validates :followed_id, presence: true
end
