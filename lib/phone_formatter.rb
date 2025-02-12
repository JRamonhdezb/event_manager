require "csv"

def clean_homephone(phone)
  phone_number = phone.delete("^a-zA-Z0-9 ").delete(" ")
  if phone_number.length.equal? 10
    phone_number
  elsif phone_number.length > 10
    if phone_number.length.equal?(11) && phone_number.start_with?("1")
      phone_number[1..]
    else
      "Wrong Number"
    end
  else
    "Wrong Number"
  end
end

puts "Phone number formatter Initialized"

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone_number = clean_homephone(row[:homephone])
  puts "ID:#{id}, Name: #{name}, Home phone: #{phone_number}"
end
