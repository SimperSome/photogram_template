require 'rails_helper'

RSpec.describe "likes#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/likes/#{like.id}", payload
  end

  describe 'basic update' do
    let!(:like) { create(:like) }

    let(:payload) do
      {
        data: {
          id: like.id.to_s,
          type: 'likes',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(LikeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { like.reload.attributes }
    end
  end
end
