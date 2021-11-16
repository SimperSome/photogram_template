class Photo < ApplicationRecord
  # Direct associations

  has_many   :likes,
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => :own_photos_count

  # Indirect associations

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

  # Scopes

  def to_s
    caption
  end

end
