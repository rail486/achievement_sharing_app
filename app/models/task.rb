class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 120 }
  validates :achievement, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
