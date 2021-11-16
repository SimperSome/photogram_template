class Photo < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :owner_id, :presence => true

  # Scopes

  def to_s
    caption
  end

end
