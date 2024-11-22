puts 'Event Manager Initialized'

lines = File.readlines('event_attendees.csv')
row_index = 0
lines.each_with_index do |line, index|
    next if index == 0
    column = line.split(",")
    name = column[2]
    puts name
end