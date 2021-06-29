FactoryBot.define do
  factory :user do
    name {"tarou"}
    sequence(:uid) {|n| "tarou#{n}"}
    introduction {"こんにちは"}
    password {"taroutarou"}
  end
end
