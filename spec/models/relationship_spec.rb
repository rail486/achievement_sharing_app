require 'rails_helper'

RSpec.describe Relationship, type: :model do

  it "True/フォローしている人、フォローされている人がいる" do





    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
end
