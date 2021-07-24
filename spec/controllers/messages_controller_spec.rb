require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
    let(:shop) { Shop.create(name: 'Test', address: 'Test address',
                             phone_number: 'Test number', website: 'Test url')}
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        expect { post :create, params: { user_id: user.id,
                                         message: {room_id: room.id, content: "Come see the event",
                                                   title: 'Message', shop_id: shop.id } }
                 }.to change(user.messages, :count).by(1)
      end
      it "redirects to the user show page" do
        sign_in user
        post :create, params: { user_id: user.id,
                                message: {room_id: room.id, content: "Come see the event",
                                          title: 'Message', shop_id: shop.id } }
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end
    context "as an non-authenticated user" do
      it "returns a 302 response" do
        post :create, params: { user_id: user.id,
                                message: {room_id: room.id, content: "Come see the event",
                                          title: 'Message', shop_id: shop.id } }
        expect(response).to have_http_status "302"
      end
    end
  end
  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { Room.create(name: "Chiyoda", room_type: "private") }
    let(:shop) { Shop.create(name: 'Test', address: 'Test address',
                             phone_number: 'Test number', website: 'Test url')}
    let!(:message) { Message.create(room: room, user: user, shop: shop,
                                    title: "Message", content: 'Come see the message!') }
    context "as an authenticated user" do
      it "responds succesfully" do
        sign_in user
        expect { delete :destroy, params: { user_id: user, id: message.id }
                 }.to change(user.messages, :count).by(-1)
      end
      it "redirects to the user show page" do
        sign_in user
        delete :destroy, params: { user_id: user, id: message.id }
        expect(response).to redirect_to "/users/#{user.id}/rooms/#{room.id}"
      end
    end
    context "as an non-authenticated user" do
      it "returns a 302 response" do
        delete :destroy, params: { user_id: user, id: message.id }
        expect(response).to have_http_status "302"
      end
    end
  end
end
