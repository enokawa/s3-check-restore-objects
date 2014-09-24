require 'aws-sdk-core'

Aws.config[:region] = 'region_name'
s3 = Aws::S3::Client.new

resp = s3.list_objects(bucket: "bucket_name")

hash = {}
resp.contents.each do |content|
	key = content.key
	hash["#{key}"] = content.storage_class
end

hash.each do |key, value|
   p "#{key}: #{value}"
end

flag = false

hash.each do |value|
	if value == "GLACIER" then
		flag = true
	elsif value == "STANDARD" then
		flag = false
	else
end

if flag == false
	p "Restore has done."
else
	p "Not yet."
end

end


#resp.contents.each do |content|
#	hash.each do |key, value|
#		key = content.key
#		hash["#{key}"] = content.storage_class
#		p "#{key}: #{value}"
#	p hash["#{key}"]
# p content.key
