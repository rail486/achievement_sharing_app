######################################################################
### File Name           : task.rb
### Version             : V1.0
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Purpose             : タスク情報に関する処理を行う．
###
######################################################################
### Revision :
### V1.0 : 木澤 航輝, 2021.07.06

class Task < ApplicationRecord
  belongs_to :user

######################################################################
### Column Name         : user_id
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Content             : 空でない
######################################################################
  validates :user_id, presence: true

######################################################################
### Column Name         : content
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Content             : 空でない
###                     : 120文字以下
######################################################################
  validates :content, presence: true, length: { maximum: 120 }

######################################################################
### Column Name         : achievement
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Content             : 空でない
###                     : 0以上 100以下
######################################################################
  validates :achievement, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

######################################################################
### Method Name         : finish_task
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : タスクの達成度を100にする．
######################################################################
  def finish_task
    self.update_attribute(:achievement, 100)
  end

######################################################################
### Method Name         : share_task
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : タスクの共有状況をTrueにする．
######################################################################
  def share_task
    self.update_attribute(:share, true)
  end

######################################################################
### Method Name         : unshare_task
### Designer            : 木澤 航輝
### Date                : 2021.07.06
### Function            : タスクの共有状況をFalseにする．
######################################################################
  def unshare_task
    self.update_attribute(:share, false)
  end
end
