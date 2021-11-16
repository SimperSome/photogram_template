require 'rails_helper'

RSpec.describe CommentResource, type: :resource do
  describe 'serialization' do
    let!(:comment) { create(:comment) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(comment.id)
      expect(data.jsonapi_type).to eq('comments')
    end
  end

  describe 'filtering' do
    let!(:comment1) { create(:comment) }
    let!(:comment2) { create(:comment) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: comment2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([comment2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:comment1) { create(:comment) }
      let!(:comment2) { create(:comment) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            comment1.id,
            comment2.id
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
            comment2.id,
            comment1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
