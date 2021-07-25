require 'rails_helper'

RSpec.describe Room, type: :model do

  describe 'room model initialization' do
    it "is valid with a name and room_type" do
      room = described_class.new(name: "Adachi",
                                 room_type: "private")
      expect(room).to be_valid
    end
    it "doesnt allow duplicate names" do
      first_room = described_class.create(name: "Chiyoda", room_type: "private")
      second_room = described_class.new(name: "Chiyoda",
                                        room_type: "private")
      second_room.valid?
      expect(second_room.errors[:name]).to include("has already been taken")
    end
    it "is invalid without a name" do
      room = described_class.new(name: nil)
      room.valid?
      expect(room.errors[:name]).to include("can't be blank")
    end
    it "is invalid without a room_type" do
      room = described_class.new(room_type: nil)
      room.valid?
      expect(room.errors[:room_type]).to include("can't be blank")
    end
  end

  describe "event model instantiation" do
    let!(:room) { described_class.create(name: "Chiyoda", room_type: "private") }

    it "allows a room to have several users" do
      user = FactoryBot.create(:user)
      user1 = FactoryBot.create(:user)
      participant = Participant.create(room: room, user: user)
      participant1 = Participant.create(room: room, user: user1)

      expect(participant1.room).to be_valid
    end
  end
end
