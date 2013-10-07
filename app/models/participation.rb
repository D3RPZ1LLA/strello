class Participation < ActiveRecord::Base
  attr_accessible :card_id, :user_id

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

  belongs_to :card,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id

  validates_presence_of :card_id, :user_id
  validates :user_id, uniqueness: { scope: :card_id }
end
