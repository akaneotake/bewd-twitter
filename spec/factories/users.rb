# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    username { "TestUser" }
    email { "unique@test.com" }
    password { "password123" }
  end
end
