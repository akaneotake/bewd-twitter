# spec/factories/sessions.rb
FactoryBot.define do
  factory :session do
    association :user
    token { "session_token" }
  end
end

# spec/factories/tweets.rb
