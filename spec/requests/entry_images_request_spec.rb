require 'rails_helper'

RSpec.describe "EntryImages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/entry_images/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/entry_images/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/entry_images/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
