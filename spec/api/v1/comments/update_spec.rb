require 'rails_helper'

RSpec.describe "comments#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/comments/#{comment.id}", payload
  end

  describe 'basic update' do
    let!(:comment) { create(:comment) }

    let(:payload) do
      {
        data: {
          id: comment.id.to_s,
          type: 'comments',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CommentResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { comment.reload.attributes }
    end
  end
end
