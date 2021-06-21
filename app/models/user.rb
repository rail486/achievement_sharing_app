class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :uid, presence: true, uniqueness: { case_sensitive: false}, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9_]+\z/, message: :invalid_uid }
  validates :introduction, length: { maximum: 120 }
  has_secure_password
  validates :password, presence: true, length: { in: 10..30 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid_password }, allow_nil: true

  def User.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
