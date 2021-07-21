require 'rails_helper'

# Use let instead of before // create several contexts inside the describe

RSpec.describe Event, type: :model do

  let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
  let(:public_room) { Room.create(name: "General", room_type: "public") }
  let(:icon) { Icon.create(name: 'default_icon', url: Icon::IMAGES[0]) }
  let(:user) { User.create(name: "Tester", alias: "Test_alias",
                           municipality: "Chiyoda-ku", email: "tester@example.com",
                           password: "1234567", icon: icon) }


  # before do
  #   @room = Room.new(name: "Chiyoda",
  #                    room_type: "private")
  #   @public_room = Room.new(name: "General",
  #                           room_type: "public")
  #   icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
  #   @user = User.new(name: "Tester",
  #                    alias: "Test_alias",
  #                    municipality: "Chiyoda-ku",
  #                    email: "tester@example.com",
  #                    password: "1234567",
  #                    icon: icon)

  # end
  it "is valid if it has a content, room_id and user_id" do
    event = described_class.new(room: @room, user: @user, content: 'Come see the event!')
    expect(event).to be_valid
  end
  it "is not valid if the content has less than 5 words" do
    event = described_class.new(room: @room, user: @user, content: 'Hi!')
    expect(event).to_not be_valid
  end
  it "should have a room_id" do
    event = described_class.new(user: @user, content: 'Come see the event!')
    event.valid?
    expect(event.errors[:room]).to include("must exist")
  end
  it "should have an user_id" do
    event = described_class.new(room: @room, content: 'Come see the event!')
    event.valid?
    expect(event.errors[:user]).to include("must exist")
  end
  it "is valid for a user to have several events" do
    event = described_class.create!(content: 'This place is so good!', user: @user, room: @room)
    event2 = described_class.create!(content: 'This place was amazing again!', user: @user, room: @public_room)
    expect(event2).to be_valid
  end
  it "is valid for a participant to have several events in the same room" do
    event = described_class.create!(content: 'This place is so good!', user: @user, room: @room)
    event2 = described_class.create!(content: 'This place was amazing again!', user: @user, room: @room)
    expect(event2).to be_valid
  end
end
