class Task < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 120 }
  validates :achievement, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def finish_task
    self.update_attribute(:achievement, 100)
  end

  def share_task
    self.update_attribute(:share, true)
  end

  def unshare_task
    self.update_attribute(:share, false)
  end
end
