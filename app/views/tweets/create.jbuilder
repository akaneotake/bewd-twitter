json.success true
json.tweet do
  json.id @tweet.id
  json.message @tweet.message
  json.user do
    json.id @tweet.user.id
    json.username @tweet.user.username
  end
  json.created_at @tweet.created_at
end
