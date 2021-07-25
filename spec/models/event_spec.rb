require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:public_room) { Room.create(name: "Events", room_type: "public") }
  let(:public_room_two) { Room.create(name: "General", room_type: "public") }
  let(:user) { FactoryBot.create(:user) }

  describe 'event model initialization' do
    it "is valid if it has a content, room_id and user_id" do
      event = described_class.new(room: public_room, user: user, content: 'Come see the event!')
      expect(event).to be_valid
    end
    it "is not valid if the content has less than 5 words" do
      event = described_class.new(room: public_room, user: user, content: 'Hi!')
      expect(event).to_not be_valid
    end
    it "should have a room_id" do
      event = described_class.new(user: user, content: 'Come see the event!')
      event.valid?
      expect(event.errors[:room]).to include("must exist")
    end
    it "should have an user_id" do
      event = described_class.new(room: public_room, content: 'Come see the event!')
      event.valid?
      expect(event.errors[:user]).to include("must exist")
    end
  end

  describe "event model instantiation" do

    let!(:first_event) { described_class.create(content: 'This place is so good!', user: user, room: public_room) }
    #we need this to run always so we use ! so that it doesnt lazy-load

    it "is valid for a user to have events in different rooms" do
      second_event = described_class.create(content: 'This place was amazing again!', user: user, room: public_room_two)
      expect(second_event).to be_valid
    end
    it "is valid for a user to have different events in the same room" do
      second_event = described_class.create(content: 'This place was amazing again!', user: user, room: public_room)
      expect(second_event).to be_valid
    end
  end
end
