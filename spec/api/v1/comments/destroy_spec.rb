require 'rails_helper'

RSpec.describe "comments#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/comments/#{comment.id}"
  end

  describe 'basic destroy' do
    let!(:comment) { create(:comment) }

    it 'updates the resource' do
      expect(CommentResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Comment.count }.by(-1)
      expect { comment.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
