require "rails_helper"

RSpec.describe "likes#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/likes/#{like.id}"
  end

  describe "basic destroy" do
    let!(:like) { create(:like) }

    it "updates the resource" do
      expect(LikeResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { Like.count }.by(-1)
      expect { like.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
