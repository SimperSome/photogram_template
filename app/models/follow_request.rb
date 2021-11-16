class FollowRequest < ApplicationRecord
  # Direct associations

  belongs_to :sender,
             :class_name => "User",
             :counter_cache => :sent_follow_requests_count

  # Indirect associations

  # Validations

  validates :recipient_id, :uniqueness => { :scope => [:sender_id], :message => "already requested" }

  validates :recipient_id, :presence => true

  validates :sender_id, :presence => true

  # Scopes

  def to_s
    created_at
  end

end
