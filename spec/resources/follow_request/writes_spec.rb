require "rails_helper"

RSpec.describe FollowRequestResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "follow_requests",
          attributes: {},
        },
      }
    end

    let(:instance) do
      FollowRequestResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { FollowRequest.count }.by(1)
    end
  end

  describe "updating" do
    let!(:follow_request) { create(:follow_request) }

    let(:payload) do
      {
        data: {
          id: follow_request.id.to_s,
          type: "follow_requests",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      FollowRequestResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { follow_request.reload.updated_at }
      # .and change { follow_request.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:follow_request) { create(:follow_request) }

    let(:instance) do
      FollowRequestResource.find(id: follow_request.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { FollowRequest.count }.by(-1)
    end
  end
end
