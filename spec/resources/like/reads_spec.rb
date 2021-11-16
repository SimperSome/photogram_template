require 'rails_helper'

RSpec.describe LikeResource, type: :resource do
  describe 'serialization' do
    let!(:like) { create(:like) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(like.id)
      expect(data.jsonapi_type).to eq('likes')
    end
  end

  describe 'filtering' do
    let!(:like1) { create(:like) }
    let!(:like2) { create(:like) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: like2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([like2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:like1) { create(:like) }
      let!(:like2) { create(:like) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            like1.id,
            like2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            like2.id,
            like1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
