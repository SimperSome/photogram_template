require 'rails_helper'

RSpec.describe "photos#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/photos/#{photo.id}"
  end

  describe 'basic destroy' do
    let!(:photo) { create(:photo) }

    it 'updates the resource' do
      expect(PhotoResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Photo.count }.by(-1)
      expect { photo.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
