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
      it "redirects to room show page" do
        sign_in user
        post :create, params: { user_id: user.id, participant: {room_id: room.id} }
        expect(response).to redirect_to "/users/#{user.id}/rooms/#{room.id}"
      end
    end
    context "as a non-authenticated user" do
      it "returns a 302 response" do
        post :create, params: { user_id: user.id, participant: {room_id: room.id} }
        expect(response).to have_http_status "302"
      end
    end
  end
  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
    let!(:participant) { Participant.create(user: user, room: room) }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        expect { delete :destroy, params: { id: user.id, room_id: room.id }
                 }.to change(room.participants, :count).by(-1)
      end
      it "redirects to the user show page" do
        sign_in user
        delete :destroy, params: { id: user.id, room_id: room.id }
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end
    context "as an non-authenticated user" do
      it "returns a 302 response" do
        delete :destroy, params: { id: user.id, room_id: room.id }
        expect(response).to have_http_status "302"
      end
    end
  end
end
