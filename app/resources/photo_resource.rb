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

end
