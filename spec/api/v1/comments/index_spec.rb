require "rails_helper"

RSpec.describe "comments#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/comments", params: params
  end

  describe "basic fetch" do
    let!(:comment1) { create(:comment) }
    let!(:comment2) { create(:comment) }

    it "works" do
      expect(CommentResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["comments"])
      expect(d.map(&:id)).to match_array([comment1.id, comment2.id])
    end
  end
end
