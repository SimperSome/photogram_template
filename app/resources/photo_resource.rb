class PhotoResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :caption, :string
  attribute :image, :string
  attribute :owner_id, :integer
  attribute :location, :string

  # Direct associations

  has_many   :comments

  has_many   :likes

  belongs_to :owner,
             resource: UserResource

  # Indirect associations

  many_to_many :fans,
               resource: UserResource

  has_many :followers, resource: UserResource, primary_key: :owner_id do
    assign_each do |photo, users|
      users.select do |u|
        u.id.in?(photo.followers.map(&:id))
      end
    end
  end

  has_many :fan_followers, resource: UserResource do
    assign_each do |photo, users|
      users.select do |u|
        u.id.in?(photo.fan_followers.map(&:id))
      end
    end
  end


  filter :sender_id, :integer do
    eq do |scope, value|
      scope.eager_load(:fan_followers).where(:follow_requests => {:sender_id => value})
    end
  end

  filter :sender_id, :integer do
    eq do |scope, value|
      scope.eager_load(:followers).where(:follow_requests => {:sender_id => value})
    end
  end
end
