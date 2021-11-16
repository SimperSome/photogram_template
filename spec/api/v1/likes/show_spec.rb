require 'rails_helper'

RSpec.describe "likes#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/likes/#{like.id}", params: params
  end

  describe 'basic fetch' do
    let!(:like) { create(:like) }

    it 'works' do
      expect(LikeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('likes')
      expect(d.id).to eq(like.id)
    end
  end
end
