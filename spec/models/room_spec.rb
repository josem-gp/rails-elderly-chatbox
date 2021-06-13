require 'rails_helper'

RSpec.describe Room, type: :model do
  it "is valid with a name and room_type" do
    room = Room.new(name: "Chiyoda",
                    room_type: "private")
    expect(room).to be_valid
  end
  it "is valid with an unique name" do
    Room.create(name: "Chiyoda",
                room_type: "private")
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
end
