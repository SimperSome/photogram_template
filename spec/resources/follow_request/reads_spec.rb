require 'rails_helper'

RSpec.describe FollowRequestResource, type: :resource do
  describe 'serialization' do
    let!(:follow_request) { create(:follow_request) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(follow_request.id)
      expect(data.jsonapi_type).to eq('follow_requests')
    end
  end

  describe 'filtering' do
    let!(:follow_request1) { create(:follow_request) }
    let!(:follow_request2) { create(:follow_request) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: follow_request2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([follow_request2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:follow_request1) { create(:follow_request) }
      let!(:follow_request2) { create(:follow_request) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            follow_request1.id,
            follow_request2.id
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
            follow_request2.id,
            follow_request1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
