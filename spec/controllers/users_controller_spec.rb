require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let!(:user) { FactoryBot.create(:user) }
    it "responds succesfully" do
      # expect(response).to have_http_status(:ok) #this is the same as the one under
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status "200"
    end
    it "renders 'home' succesfully" do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
    end
  end
end
