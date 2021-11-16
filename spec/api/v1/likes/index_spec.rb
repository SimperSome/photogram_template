require 'rails_helper'

RSpec.describe "likes#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/likes", params: params
  end

  describe 'basic fetch' do
    let!(:like1) { create(:like) }
    let!(:like2) { create(:like) }

    it 'works' do
      expect(LikeResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['likes'])
      expect(d.map(&:id)).to match_array([like1.id, like2.id])
    end
  end
end
