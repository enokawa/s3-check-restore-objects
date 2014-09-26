require 'aws-sdk-core'
require 'gmail'

Aws.config[:region] = 'your region'
s3 = Aws::S3::Client.new

gmail = Gmail.connect(ENV["GMAIL_ID"], ENV["GMAIL_PASS"])

resp = s3.list_objects(bucket: "your-bucket")

timeout = 0
while true do

hash = {}
## ハッシュにキーを格納
resp.contents.each do |content|
  key = content.key
  hash["#{key}"] = content.storage_class
end

## キーとバリューを出力
hash.each do |key, value|
  p "#{key}: #{value}"
end

ct = hash.count
count = 0

## Storage Classをチェック
hash.each do |key, value|
  if value == "STANDARD"
    count += 1
  end
end

## STANDARD / オブジェクト数
p "#{count}/#{ct}"

## 全てSTANDARDならsucessにfalseを代入してbreak
if count == ct
  sucess = true
  break
end

timeout += 1

## timeoutが3ならsucessにfalseを代入
if timeout == 3 then
  sucess = false
  break
end

## 10秒sleep
sleep 10

end # while

## もしsucessがtrueならメールを送信、falseならエラーメッセージ
if sucess == true
  p "Restore has done."
  gmail.deliver do
  to "example@example.com"
  subject "Glacier Notification"
  text_part do
    body "Restore has done!!"
  end
end
p "Sent an e-mail."
  else
  p "FAILED"
end

gmail.logout
