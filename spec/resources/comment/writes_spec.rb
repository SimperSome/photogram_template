require "rails_helper"

RSpec.describe CommentResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "comments",
          attributes: {},
        },
      }
    end

    let(:instance) do
      CommentResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Comment.count }.by(1)
    end
  end

  describe "updating" do
    let!(:comment) { create(:comment) }

    let(:payload) do
      {
        data: {
          id: comment.id.to_s,
          type: "comments",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      CommentResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { comment.reload.updated_at }
      # .and change { comment.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:comment) { create(:comment) }

    let(:instance) do
      CommentResource.find(id: comment.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Comment.count }.by(-1)
    end
  end
end
