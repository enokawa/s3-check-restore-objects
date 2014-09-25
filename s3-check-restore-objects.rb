require 'aws-sdk-core'

Aws.config[:region] = 'region_name'
s3 = Aws::S3::Client.new

resp = s3.list_objects(bucket: "bucket_name")

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
