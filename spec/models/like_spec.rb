require 'rails_helper'

RSpec.describe Like, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:user) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do

    it { should validate_uniqueness_of(:photo_id).scoped_to(:user_id).with_message('already liked') }

    it { should validate_presence_of(:photo_id) }

    it { should validate_presence_of(:user_id) }

    end
end
