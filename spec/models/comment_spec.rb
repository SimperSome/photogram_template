require 'rails_helper'

RSpec.describe Comment, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:photo) }

    it { should belong_to(:commenter) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do

    it { should validate_presence_of(:body) }

    it { should validate_presence_of(:commenter_id) }

    it { should validate_presence_of(:photo_id) }

    end
end
