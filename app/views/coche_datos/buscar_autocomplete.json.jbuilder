json.array!(@people) do |person|
	json.name person.car 
  json.link  'https://google.com/search?q=' +
            CGI.escape(person.car)
end
