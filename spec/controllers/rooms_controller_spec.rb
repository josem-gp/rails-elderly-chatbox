require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe "GET #show" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        get :show, params: { id: room.id, user_id: user.id}
        expect(response).to have_http_status "200"
      end
      it "renders 'room' succesfully" do
        sign_in user
        get :show, params: { id: room.id, user_id: user.id}
        expect(response).to render_template('show')
      end
    end

    context "as a non-authenticated user" do
      it "returns a 302 response" do
        get :show, params: { id: room.id, user_id: user.id}
        expect(response).to have_http_status "302"
      end
      it "redirects to the sign_in page" do
        get :show, params: { id: room.id, user_id: user.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
