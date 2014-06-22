require 'JSON'
require 'rest-client'

puts "Hello! Welcome to donorschoose.org!"

offset = 0

while true

	puts "Would you like to search by subject, state, poverty level, or resource type?"

	choice = gets.strip

	if choice == "subject"
		puts "What subject would you like to search for?"
		subject = gets.strip
		puts "Loading..."
		response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?max=10&index=#{offset}&subject=#{subject}&APIKey=DONORSCHOOSE")
	elsif choice == "state"
		puts "Please enter the state initials."
		state = gets.strip
		puts "Loading..."
		response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?max=10&index=#{offset}&state=#{state}&APIKey=DONORSCHOOSE")
	elsif choice == "resource type"
		puts "Enter the number for your desired resource type.\n1 Books\n2 Technology\n3 Supplies\n4 Trips\n5 Visitors\n6 Other"
		resource_type = gets.strip
		puts "Loading..."
		response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?max=10&index=#{offset}&proposalType=#{resource_type}&APIKey=DONORSCHOOSE")
	elsif choice == "poverty level"
		puts "Loading..."
		response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?max=10&index=#{offset}&highLevelPovery=true&APIKey=DONORSCHOOSE")
	else
		puts "Please enter a valid search term."
	end

	next unless response

	parsed_response = JSON.parse(response)

	results = parsed_response["proposals"]
	#array of hashes

	results.each_with_index do |proposal, index|
		if offset < results.length - 1
			title = results[index + offset]["title"]
			description = results[index + offset]["shortDescription"]
			fund_url = results[index + offset]["fundURL"]
			puts "#{offset + index + 1}. (#{title}): #{description}, #{fund_url}"
		else
			puts "For more results, check out www.donorschoose.org or try again with a different search parameter."
			break
		end
	end

	puts "Would you like to search again? (Y/N)"

	break unless gets.strip == "Y"

	offset += 10

end