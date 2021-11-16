require "rails_helper"

RSpec.describe "follow_requests#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/follow_requests/#{follow_request.id}"
  end

  describe "basic destroy" do
    let!(:follow_request) { create(:follow_request) }

    it "updates the resource" do
      expect(FollowRequestResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { FollowRequest.count }.by(-1)
      expect { follow_request.reload }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
