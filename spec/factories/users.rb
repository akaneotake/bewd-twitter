FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    username { "testuser" }
    password { "password123" }
  end
end
