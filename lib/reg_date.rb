require "csv"
require "rubocop"

WEEKDAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

def hours_frequency(dates)
  hours = dates.map(&:hour)
  hours = hours.each_with_object(Hash.new(0)) do |value, result|
    result[value] += 1
  end
  hours = hours.sort_by { |key, _value| -key }.to_h
  hours.each { |k, v| puts "Hour #{k} => Frequency = #{v}" }
  mode = largest_hash_key(hours)
  puts "The best times to post social media ads during the day: #{mode} o'clock"
end

def largest_hash_key(hash)
  max = hash[hash.key(hash.values.max)]
  array = []
  hash.each { |k, v| array << k if max == v }
  array
end

def weekday_frequency(dates)
  days = dates.map(&:wday)
  days = days.each_with_object(Hash.new(0)) do |value, result|
    result[value] += 1
  end
  days = days.sort_by { |key, _value| -key }.to_h
  max = largest_hash_key(days)[0]
  puts "Day with the highest frequency of attendance registrations in the week: #{WEEKDAYS[max]}"
end

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

dates = []
contents.each do |row|
  dates << Time.strptime(row[:regdate], "%m/%d/%Y %k:%M")
rescue StandardError
  "Wrong format"
end
puts "Frequency reg hours =>"
hours_frequency(dates)
puts "\nFrequency reg week days =>"
weekday_frequency(dates)
