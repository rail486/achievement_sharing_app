######################################################################
### File Name           : user.rb
### Version             : V1.0
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Purpose             : 記憶トークンの作成，保存などの利用者情報に関する
###                       処理を行う．
###
######################################################################
### Revision :
### V1.0 : 宮島 健太, 2021.07.06

class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :tasks, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

######################################################################
### Column Name         : name
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 空でない
###                     : 30文字以下
######################################################################
  validates :name, presence: true, length: { maximum: 30 }

######################################################################
### Column Name         : uid
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 空でない
###                     : 大文字と小文字を区別せずに一意である
###                     : 30文字以下
###                     : 半角英数字，アンダーバーのみ使用可能
######################################################################
  validates :uid, presence: true, uniqueness: { case_sensitive: false}, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9_]+\z/, message: :invalid_uid }

######################################################################
### Column Name         : introduction
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 120文字以下
######################################################################
  validates :introduction, length: { maximum: 120 }

######################################################################
### Column Name         : password
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Content             : 空でない
###                     : 10文字以上 30文字以下
###                     : 半角英数字のみ使用可能
###                     : nilの場合，バリデーションをスキップする
######################################################################
  has_secure_password
  validates :password, presence: true, length: { in: 10..30 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid_password }, allow_nil: true

######################################################################
### Method Name         : User.digest
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数の文字列のハッシュ値を返す．
######################################################################
  def User.digest(str)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
    BCrypt::Password.create(str, cost: cost)
  end

######################################################################
### Method Name         : User.new_token
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : ランダムなトークンを返す．
######################################################################
  def User.new_token
    SecureRandom.urlsafe_base64
  end

######################################################################
### Method Name         : remember
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : データベースにランダムなトークンを保存する．
######################################################################
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

######################################################################
### Method Name         : authenticated?
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数のトークンと記憶トークンが一致する場合は
###                       Trueを返し，異なる場合はFalseを返す．
######################################################################
  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

######################################################################
### Method Name         : forget
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 記憶トークンを削除する．
######################################################################
  def forget
    update_attribute(:remember_digest, nil)
  end

######################################################################
### Method Name         : User.search
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数の文字列を利用者IDに含む利用者の情報を返す．
###                       引数が空の場合は，すべての利用者の情報を返す．
######################################################################
  def User.search(search)
    if search
      User.where(['uid LIKE ?', "%#{search}%"]).order(:id)
    else
      User.all.order(:id)
    end
  end

######################################################################
### Method Name         : follow
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数の利用者をフォローする．
######################################################################
  def follow(other_user)
    following << other_user
  end

######################################################################
### Method Name         : unfollow
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数の利用者をフォロー解除する．
######################################################################
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

######################################################################
### Method Name         : following?
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 引数の利用者をフォローしている場合，Trueを返す．
######################################################################
  def following?(other_user)
    following.include?(other_user)
  end

######################################################################
### Method Name         : filter
### Designer            : 宮島 健太
### Date                : 2021.07.06
### Function            : 利用者がフォローしている利用者と利用者本人の，
###                       タスクを返す．
######################################################################
  def filter
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Task.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end
end
