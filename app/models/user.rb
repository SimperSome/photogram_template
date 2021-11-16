class User < ApplicationRecord
  # Direct associations

  has_many   :comments,
             :foreign_key => "commenter_id",
             :dependent => :destroy

  has_many   :likes,
             :dependent => :destroy

  # Indirect associations

  # Validations

  validates :username, :uniqueness => true

  validates :username, :presence => true

  # Scopes

  def to_s
    username
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
