require 'rails_helper'

# Use let instead of before // create several contexts inside the describe

RSpec.describe Message, type: :model do
  before do
    icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
    @room = Room.new(name: "Chiyoda",
                     room_type: "private")
    @public_room = Room.new(name: "General",
                            room_type: "public")
    @user = User.new(name: "Tester",
                     alias: "Test_alias",
                     municipality: "Chiyoda-ku",
                     email: "tester@example.com",
                     password: "1234567",
                     icon: icon)
    @shop = Shop.new(name: 'Test', address: 'Test address', phone_number: 'Test number', website: 'Test url')
  end
  it "is valid with a title, content, votes, user_id, shop_id and room_id" do
    message = Message.new(title: 'Message', content: 'This place is so good!', vote: 1, user: @user, room: @room, shop: @shop)
    expect(message).to be_valid
  end
  it "must have a title" do
    message = Message.new(content: 'This place is so good!', vote: 1, user: @user, room: @room, shop: @shop)
    message.valid?
    expect(message.errors[:title]).to include("can't be blank")
  end
  it "must have a content" do
    message = Message.new(title: 'Test', vote: 1, user: @user, room: @room, shop: @shop)
    message.valid?
    expect(message.errors[:content]).to include("can't be blank")
  end
  it "must have a content with more than 5 characters" do
    message = Message.new(title: 'Message', content: 'Test', vote: 1, user: @user, room: @room, shop: @shop)
    message.valid?
    expect(message.errors[:content]).to include('is too short (minimum is 5 characters)')
  end
  it "must have a room_id" do
    message = Message.new(title: 'Test', content: 'This place is so good!', vote: 1, user: @user, shop: @shop)
    message.valid?
    expect(message.errors[:room]).to include("must exist")
  end
  it "must have a user_id" do
    message = Message.new(title: 'Test', content: 'This place is so good!', vote: 1, room: @room, shop: @shop)
    message.valid?
    expect(message.errors[:user]).to include("must exist")
  end
  it "must have a shop_id" do
    message = Message.new(title: 'Test', content: 'This place is so good!', vote: 1, room: @room, user: @user)
    message.valid?
    expect(message.errors[:shop]).to include("must exist")
  end
  it "is valid for a user to have several messages" do
    message = Message.create!(title: 'Message', content: 'This place is so good!', vote: 1, user: @user, room: @room, shop: @shop)
    message2 = Message.create!(title: 'Message2', content: 'This place was amazing again!', vote: 1, user: @user, room: @public_room, shop: @shop)
    expect(message2).to be_valid
  end
  it "is valid for a user to have several messages in the same room" do
    message = Message.create!(title: 'Message', content: 'This place is so good!', vote: 1, user: @user, room: @room, shop: @shop)
    message2 = Message.create!(title: 'Message2', content: 'This place was amazing again!', vote: 1, user: @user, room: @room, shop: @shop)
    expect(message2).to be_valid
  end
end
