class CommentResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :body, :string
  attribute :commenter_id, :integer
  attribute :photo_id, :integer

  # Direct associations

  # Indirect associations

end
