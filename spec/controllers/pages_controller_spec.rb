require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#home" do
    it "responds succesfully" do
      get :home
      expect(response).to have_http_status(:ok)
    end
    it "renders 'home' succesfully" do
      get :home
      expect(response).to render_template('home')
    end
  end
end
