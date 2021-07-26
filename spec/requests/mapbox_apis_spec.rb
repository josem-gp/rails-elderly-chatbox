require 'rails_helper'

RSpec.describe "MapboxApis", type: :request do
  describe "GET /mapbox_apis" do
    it "works! (now write some real specs)" do
      get mapbox_apis_path
      expect(response).to have_http_status(200)
    end
  end
end
