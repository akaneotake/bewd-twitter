json.tweets @tweets do |tweet|
  json.id tweet.id
  json.username tweet.user.username # userのusernameを追加
  json.message tweet.message
end