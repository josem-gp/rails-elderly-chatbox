require 'rails_helper'

RSpec.describe ParticipantsController, type: :controller do
  describe "POST #show" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        expect { post :create, params: { user_id: user.id,
                                         participant: {room_id: room.id} } }.to change(room.participants, :count).by(1)
      end
    end
    context "as a non-authenticated user" do
      it "returns a 302 response" do
        # get :show, params: { id: room.id, user_id: user.id}
        # expect(response).to have_http_status "302"
      end
    end
  end
end
