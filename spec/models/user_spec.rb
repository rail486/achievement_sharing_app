require 'rails_helper'

RSpec.describe User, type: :model do

  it "True/表示名、ID、パスワードがある 自己紹介がある" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "False/表示名がない" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "True/表示名が30文字" do
    user = FactoryBot.build(:user, name: "a"*30)
    expect(user).to be_valid
  end

  it "False/表示名が30文字より多い" do
    user = FactoryBot.build(:user, name: "a"*31)
    user.valid?
    expect(user.errors[:name]).to include("は30文字以内で入力してください")
  end

  it "False/IDがない" do
    user = FactoryBot.build(:user, uid: nil)
    user.valid?
    expect(user.errors[:uid]).to include("を入力してください")
  end

  it "False/IDが重複" do
    user1 = FactoryBot.build(:user, name: "tarou", uid: "tarou")
    user2 = FactoryBot.build(:user, name: "hanako", uid: "tarou")
    user2.valid?
    expect(user2.errors[:uid]).to include("はすでに存在します")
  end

  it "False/IDが重複(英語、大文字小文字の違い)" do
    user1 = FactoryBot.build(:user, name: "tarou", uid: "tarou")
    user2 = FactoryBot.build(:user, name: "hanako", uid: "TAROU")
    user2.valid?
    expect(user2.errors[:uid]).to include("はすでに存在します")
  end

  it "True/IDが30文字" do
    user = FactoryBot.build(:user, uid: "a"*30)
    expect(user).to be_valid
  end

  it "False/IDが30文字より多い" do
    user = FactoryBot.build(:user, uid: "a"*31)
    user.valid?
    expect(user.errors[:uid]).to include("は30文字以内で入力してください")
  end

  it "True/IDが半角英数字、アンダーバー" do
    user = FactoryBot.build(:user, uid: "Tarou_2")
    expect(user).to be_valid
  end
  
  it "False/IDに不正な文字" do
    user = FactoryBot.build(:user)
    ["あ", "亜", "ア", "１", "-", ".", "@"].each do |value|
      user.uid = value
      user.valid?
      expect(user.errors[:uid]).to include("は半角英数字、アンダーバーが使用できます")
    end
  end

  it "True/自己紹介がない" do
    user = FactoryBot.build(:user, introduction: nil)
    expect(user).to be_valid
  end

  it "False/パスワードがない" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "False/パスワードが10文字未満" do
    user = FactoryBot.build(:user, password: "a"*9)
    user.valid?
    expect(user.errors[:password]).to include("は10文字以上で入力してください")
  end

  it "True/パスワードが10文字" do
    user = FactoryBot.build(:user, password: "a"*10)
    expect(user).to be_valid
  end

  it "True/パスワードが30文字" do
    user = FactoryBot.build(:user, password: "a"*30)
    expect(user).to be_valid

  end

  it "False/パスワードが30文字より多い" do
    user = FactoryBot.build(:user, password: "a"*31)
    user.valid?
    expect(user.errors[:password]).to include("は30文字以内で入力してください")
  end

  it "True/パスワードが半角英数字" do
    user = FactoryBot.build(:user, uid: "TarouTarou22")
    expect(user).to be_valid
  end

  it "False/パスワードに不正な文字" do
    user = FactoryBot.build(:user)
    ["あ", "亜", "ア", "１", "-", ".", "@", "_"].each do |value|
      user.password = value
      user.valid?
      expect(user.errors[:password]).to include("は半角英数字のみが使用できます")
    end
  end

  it "パスワードが暗号化されている" do
    user = FactoryBot.build(:user)
    expect(user.password_digest).to_not eq "password"
  end

  it "False/パスワードとパスワード(確認用)が異なる場合" do
    user = FactoryBot.build(:user, password: "taroutarou", password_confirmation: "hanakohanako")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
end
