FactoryBot.define do
  factory :tweet do
    association :user
    message { "This is a tweet" }
  end
end
