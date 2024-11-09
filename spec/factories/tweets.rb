FactoryBot.define do
  factory :tweet do
    message { "This is a test tweet" }
    association :user
  end
end
