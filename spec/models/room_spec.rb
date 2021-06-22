require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = Room.create(name: "Chiyoda",
                        room_type: "private")
  end
  it "is valid with a name and room_type" do
    room = Room.new(name: "Adachi",
                    room_type: "private")
    expect(room).to be_valid
  end
  it "doesnt allow duplicate names" do
    room = Room.new(name: "Chiyoda",
                    room_type: "private")
    room.valid?
    expect(room.errors[:name]).to include("has already been taken")
  end
  it "is invalid without a name" do
    room = Room.new(name: nil)
    room.valid?
    expect(room.errors[:name]).to include("can't be blank")
  end
  it "is invalid without a room_type" do
    room = Room.new(room_type: nil)
    room.valid?
    expect(room.errors[:room_type]).to include("can't be blank")
  end
  it "allows a room to have several users" do
    icon = Icon.create!(name: 'default_icon', url: Icon::IMAGES[0])
    user = User.create!(name: "Tester",
                        alias: "Test_alias",
                        municipality: "Chiyoda-ku",
                        email: "tester@example.com",
                        password: "1234567",
                        icon: icon)
    icon = Icon.create!(name: 'default_icon', url: Icon::IMAGES[0])
    user1 = User.create!(name: "Tester1",
                         alias: "Test_alias1",
                         municipality: "Chiyoda-ku",
                         email: "tester1@example.com",
                         password: "1234567",
                         icon: icon)
    participant = Participant.create(room: @room, user: user)
    participant1 = Participant.create(room: @room, user: user1)

    expect(participant1.room).to be_valid
  end
end
