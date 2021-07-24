require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:public_room) { Room.create(name: "General", room_type: "public") }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        # post :create, params: { user_id: user.id, event: {room_id: public_room.id, content: "Come see the event" } } #this is the post test. it needs an user_id and then the event is required in its params (check events_controller)
        expect { post :create, params: { user_id: user.id, event: {room_id: public_room.id, content: "Come see the event" } }
                 }.to change(user.events, :count).by(1)
      end
      it "redirects to the user show page" do
        sign_in user
        post :create, params: { user_id: user.id, event: {room_id: public_room.id, content: "Come see the event" } }
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end
    context "as an non-authenticated user" do
      it "returns a 302 response" do
        post :create, params: { user_id: user.id, event: {room_id: public_room.id, content: "Come see the event" } }
        expect(response).to have_http_status "302"
      end
    end
  end
  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:public_room) { Room.create(name: "General", room_type: "public") }
    let!(:event) { Event.create(room: public_room, user: user, content: 'Come see the event!') }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        expect { delete :destroy, params: { user_id: user, id: event.id }
                 }.to change(user.events, :count).by(-1)
      end
      it "redirects to the user show page" do
        sign_in user
        delete :destroy, params: { user_id: user, id: event.id }
        expect(response).to redirect_to "/users/#{user.id}/rooms/#{public_room.id}"
      end
    end
    context "as an non-authenticated user" do
      it "returns a 302 response" do
        delete :destroy, params: { user_id: user, id: event.id }
        expect(response).to have_http_status "302"
      end
    end
  end
end
