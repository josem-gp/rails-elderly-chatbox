require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
  let(:room_two) { Room.create(name: "Bunkyo", room_type: "private") }
  let(:icon) { Icon.create(name: 'default_icon', url: Icon::IMAGES[0]) }
  let(:user) { User.create(name: "Tester", alias: "Test_alias",
                           municipality: "Chiyoda-ku", email: "tester@example.com",
                           password: "1234567", icon: icon) }
  let(:shop) { Shop.create(name: 'Test', address: 'Test address',
                           phone_number: 'Test number', website: 'Test url')}

  describe 'message model initialization' do
    it "is valid with a title, content, votes, user_id, shop_id and room_id" do
      message = described_class.new(title: 'Message', content: 'This place is so good!', vote: 1, user: user, room: room, shop: shop)
      expect(message).to be_valid
    end
    it "must have a title" do
      message = described_class.new(content: 'This place is so good!', vote: 1, user: user, room: room, shop: shop)
      message.valid?
      expect(message.errors[:title]).to include("can't be blank")
    end
    it "must have a content" do
      message = described_class.new(title: 'Test', vote: 1, user: user, room: room, shop: shop)
      message.valid?
      expect(message.errors[:content]).to include("can't be blank")
    end
    it "must have a content with more than 5 characters" do
      message = described_class.new(title: 'Message', content: 'Test', vote: 1, user: user, room: room, shop: shop)
      message.valid?
      expect(message.errors[:content]).to include('is too short (minimum is 5 characters)')
    end
    it "must have a room_id" do
      message = described_class.new(title: 'Test', content: 'This place is so good!', vote: 1, user: user, shop: shop)
      message.valid?
      expect(message.errors[:room]).to include("must exist")
    end
    it "must have a user_id" do
      message = described_class.new(title: 'Test', content: 'This place is so good!', vote: 1, room: room, shop: shop)
      message.valid?
      expect(message.errors[:user]).to include("must exist")
    end
    it "must have a shop_id" do
      message = described_class.new(title: 'Test', content: 'This place is so good!', vote: 1, room: room, user: user)
      message.valid?
      expect(message.errors[:shop]).to include("must exist")
    end
  end

  describe "message model instantiation" do
    let!(:first_message) { described_class.create(title: 'Message',
                                                  content: 'This place is so good!',
                                                  vote: 1, user: user, room: room,
                                                  shop: shop) }
    #we need this to run always so we use ! so that it doesnt lazy-load

    it "is valid for a user to have messages in different rooms" do
      second_message = described_class.create(title: 'Second Message', content: 'This place was amazing again!', vote: 1, user: user, room: room_two, shop: shop)
      expect(second_message).to be_valid
    end
    it "is valid for a user to have different messages in the same room" do
      second_message = described_class.create(title: 'Second Message', content: 'This place was amazing again!', vote: 1, user: user, room: room, shop: shop)
      expect(second_message).to be_valid
    end
  end
end
