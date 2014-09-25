require 'aws-sdk-core'

Aws.config[:region] = 'ap-northeast-1'
s3 = Aws::S3::Client.new

resp = s3.list_objects(bucket: "enokawatest")

hash = {}
flag = false

while flag == true do

resp.contents.each do |content|
	key = content.key
	hash["#{key}"] = content.storage_class
end

hash.each do |key, value|
   p "#{key}: #{value}"
end

hash.each do |value|
	if value == "GLACIER" then
		flag = true
	elsif value == "STANDARD" then
		flag = false
	else
	end
end

end
