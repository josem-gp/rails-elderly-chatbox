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

puts "Delete all messages"

Message.delete_all

puts "Delete all participants"

Participant.delete_all

puts "Delete all users"

User.delete_all

puts "Delete all icons"

Icon.delete_all

puts "Deleting all rooms"

Room.delete_all

puts "Creating private rooms database...."

addresses = User::ADDRESSES
icons = Icon::IMAGES[1..-1]

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

puts "Creating Icons"

icons.each_with_index do |icon, idx|
  Icon.create!(name: "icon#{idx}", url: "#{icon}")
end

puts "Done!"

puts "Creating Trial User"

user = User.new(name: 'jose garcia', age: 28, municipality: 'Chuo-ku', alias: 'josegp91', email: 'jose@hotmail.com', password: '1234567')
user.save!
puts "Trial User created!"
