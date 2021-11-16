require "rails_helper"

RSpec.describe "photos#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/photos", params: params
  end

  describe "basic fetch" do
    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    it "works" do
      expect(PhotoResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["photos"])
      expect(d.map(&:id)).to match_array([photo1.id, photo2.id])
    end
  end
end
