# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def cleaning_name(address)
  address.match(/(\w*)-/)[1].strip
end

puts "Creating private rooms database...."

addresses = User::ADDRESSES

puts "There are #{addresses.count} private rooms..."

addresses.each_with_index do |address,idx|
  room = Room.new(name: cleaning_name(address),
                  room_type: 'private')
  room.save!
  puts "#{idx+1}. #{room[:name]} saved!"
end

puts "Private rooms created!"

puts "Creating general rooms database"

room = Room.create!(name: 'Promotions', room_type: 'public')
puts "#{room[:name]} saved!"
room = Room.create!(name: 'General', room_type: 'public')
puts "#{room[:name]} saved!"
room = Room.create!(name: 'Events', room_type: 'public')
puts "#{room[:name]} saved!"

puts "General rooms created!"



