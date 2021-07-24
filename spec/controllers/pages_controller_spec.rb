require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    let!(:call) { get :home }
    it "responds succesfully" do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'home' succesfully" do
      expect(response).to render_template('home')
    end
  end
end
