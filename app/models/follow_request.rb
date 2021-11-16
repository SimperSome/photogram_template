class FollowRequest < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :sender_id, :presence => true

  # Scopes

  def to_s
    created_at
  end

end
