class Participation < ActiveRecord::Base
  attr_accessible :card_id, :user_id
  # add validation to check that user is a member of the board

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

  belongs_to :card,
  inverse_of: :participations,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id

  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :card_id }
end
