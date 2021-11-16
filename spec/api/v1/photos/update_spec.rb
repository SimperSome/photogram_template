require "rails_helper"

RSpec.describe "photos#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/photos/#{photo.id}", payload
  end

  describe "basic update" do
    let!(:photo) { create(:photo) }

    let(:payload) do
      {
        data: {
          id: photo.id.to_s,
          type: "photos",
          attributes: {
            # ... your attrs here
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit "updates the resource" do
      expect(PhotoResource).to receive(:find).and_call_original
      expect do
        make_request
        expect(response.status).to eq(200), response.body
      end.to change { photo.reload.attributes }
    end
  end
end
