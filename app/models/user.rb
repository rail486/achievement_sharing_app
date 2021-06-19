class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :uid, presence: true, uniqueness: { case_sensitive: false}, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
  has_secure_password
  validates :password, presence: true, length: { in: 10..30 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
