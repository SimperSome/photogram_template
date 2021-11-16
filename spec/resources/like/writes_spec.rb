require 'rails_helper'

RSpec.describe LikeResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'likes',
          attributes: { }
        }
      }
    end

    let(:instance) do
      LikeResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Like.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:like) { create(:like) }

    let(:payload) do
      {
        data: {
          id: like.id.to_s,
          type: 'likes',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      LikeResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { like.reload.updated_at }
      # .and change { like.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:like) { create(:like) }

    let(:instance) do
      LikeResource.find(id: like.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Like.count }.by(-1)
    end
  end
end
