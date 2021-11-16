require "rails_helper"

RSpec.describe "comments#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/comments/#{comment.id}", params: params
  end

  describe "basic fetch" do
    let!(:comment) { create(:comment) }

    it "works" do
      expect(CommentResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("comments")
      expect(d.id).to eq(comment.id)
    end
  end
end
