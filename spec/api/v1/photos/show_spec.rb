require "rails_helper"

RSpec.describe "photos#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/photos/#{photo.id}", params: params
  end

  describe "basic fetch" do
    let!(:photo) { create(:photo) }

    it "works" do
      expect(PhotoResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("photos")
      expect(d.id).to eq(photo.id)
    end
  end
end
