class UserResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :email, :string
  attribute :password, :string
  attribute :username, :string

  # Direct associations

  has_many   :sent_follow_requests,
             resource: FollowRequestResource,
             foreign_key: :sender_id

  has_many   :comments,
             foreign_key: :commenter_id

  has_many   :likes

  # Indirect associations

end
