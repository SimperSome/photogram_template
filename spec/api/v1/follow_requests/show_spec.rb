require 'rails_helper'

RSpec.describe "follow_requests#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/follow_requests/#{follow_request.id}", params: params
  end

  describe 'basic fetch' do
    let!(:follow_request) { create(:follow_request) }

    it 'works' do
      expect(FollowRequestResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('follow_requests')
      expect(d.id).to eq(follow_request.id)
    end
  end
end
