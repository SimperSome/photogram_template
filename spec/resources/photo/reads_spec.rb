require "rails_helper"

RSpec.describe PhotoResource, type: :resource do
  describe "serialization" do
    let!(:photo) { create(:photo) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(photo.id)
      expect(data.jsonapi_type).to eq("photos")
    end
  end

  describe "filtering" do
    let!(:photo1) { create(:photo) }
    let!(:photo2) { create(:photo) }

    context "by id" do
      before do
        params[:filter] = { id: { eq: photo2.id } }
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([photo2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:photo1) { create(:photo) }
      let!(:photo2) { create(:photo) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      photo1.id,
                                      photo2.id,
                                    ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
                                      photo2.id,
                                      photo1.id,
                                    ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
