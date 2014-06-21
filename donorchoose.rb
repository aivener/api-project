require 'JSON'
require 'rest-client'

puts "Hello! Welcome to donorschoose.org!"

#would you like to search by subject? (y/n) if y, give possibilities
#or, would you like to search by community (y/n)?
#or, would you like to search by resource type?

puts "Would you like to search by subject, state, or resource type?"

choice = gets.strip

url = "http://api.donorschoose.org/common/json_feed.html?APIKey=DONORSCHOOSE"

if choice == "subject"
	puts "What subject would you like to search for?"
	subject = gets.strip
	response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?subject=#{subject}&APIKey=DONORSCHOOSE")
	parsed_response = JSON.parse(response)
elsif choice == "community"
	puts "Please enter the state initials."
	state = gets.strip
	response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?state=#{state}&APIKey=DONORSCHOOSE")
	parsed_response = JSON.parse(response)
elsif choice == "resource type"
	puts "Enter the number for your desired resource type.\n1 Books\n2 Technology\n3 Supplies\n4 Trips\n5 Visitors\n Other"
	resource_type = gets.strip
	response = RestClient.get("http://api.donorschoose.org/common/json_feed.html?proposalType=#{resource_type}&APIKey=DONORSCHOOSE")
	parsed_response = JSON.parse(response)
else
	puts "Please enter a valid search term."
end

#do stuff with parsed_response