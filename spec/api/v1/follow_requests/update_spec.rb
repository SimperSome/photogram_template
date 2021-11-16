require 'rails_helper'

RSpec.describe "follow_requests#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/follow_requests/#{follow_request.id}", payload
  end

  describe 'basic update' do
    let!(:follow_request) { create(:follow_request) }

    let(:payload) do
      {
        data: {
          id: follow_request.id.to_s,
          type: 'follow_requests',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(FollowRequestResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { follow_request.reload.attributes }
    end
  end
end
