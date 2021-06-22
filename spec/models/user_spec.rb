require 'rails_helper'

RSpec.describe User, type: :model do

  # サブジェクト
  subject(:user) { build(:user) }

  # サブジェクトの有効性
  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:uid) }
  it { should respond_to(:introduction) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_digest) }
  it { should respond_to(:active_relationships) }
  it { should respond_to(:passive_relationships) }
  it { should respond_to(:following) }
  it { should respond_to(:followers) }
  it { should respond_to(:follow) }
  it { should respond_to(:unfollow) }
  it { should respond_to(:following?) }

end
