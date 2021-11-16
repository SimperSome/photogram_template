class Like < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :photo_id, :presence => true

  validates :user_id, :presence => true

  # Scopes

  def to_s
    created_at
  end

end
