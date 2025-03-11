json.tweets @tweets do |tweet|
  json.id tweet.id
  json.message tweet.message
  json.created_at tweet.created_at
  json.user do
    json.id tweet.user.id
    json.name tweet.user.name
  end
end