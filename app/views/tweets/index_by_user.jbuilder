json.user do
  json.id @tweets.first.user.id
  json.username @tweets.first.user.username
  json.name @tweets.first.user.name
end

json.tweets @tweets do |tweet|
  json.id tweet.id
  json.message tweet.message
  json.created_at tweet.created_at
end