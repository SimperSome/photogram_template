require "rails_helper"

RSpec.describe "follow_requests#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/follow_requests", params: params
  end

  describe "basic fetch" do
    let!(:follow_request1) { create(:follow_request) }
    let!(:follow_request2) { create(:follow_request) }

    it "works" do
      expect(FollowRequestResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["follow_requests"])
      expect(d.map(&:id)).to match_array([follow_request1.id,
                                          follow_request2.id])
    end
  end
end
