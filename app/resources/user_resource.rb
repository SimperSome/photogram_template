class UserResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :email, :string
  attribute :password, :string
  attribute :username, :string

  # Direct associations

  has_many   :own_photos,
             resource: PhotoResource,
             foreign_key: :owner_id

  has_many   :received_follow_requests,
             resource: FollowRequestResource,
             foreign_key: :recipient_id

  has_many   :sent_follow_requests,
             resource: FollowRequestResource,
             foreign_key: :sender_id

  has_many   :comments,
             foreign_key: :commenter_id

  has_many   :likes

  # Indirect associations

  has_many :activity, resource: PhotoResource do
    assign_each do |user, photos|
      photos.select do |p|
        p.id.in?(user.activity.map(&:id))
      end
    end
  end


  filter :photo_id, :integer do
    eq do |scope, value|
      scope.eager_load(:activity).where(:likes => {:photo_id => value})
    end
  end
end
