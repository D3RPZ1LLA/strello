class Card < ActiveRecord::Base
  attr_accessible :description, :due_date, :start_date, :title, :catagory_id

  belongs_to :catagory,
  class_name: "Catagory",
  foreign_key: :catagory_id,
  primary_key: :id

  has_one :board, through: :catagory, source: :board

  has_many :checklists,
  class_name: "Checklist",
  foreign_key: :card_id,
  primary_key: :id

  has_many :participations,
  inverse_of: :card,
  class_name: "Participation",
  foreign_key: :card_id,
  primary_key: :id

  has_many :participants, through: :participations, source: :user

  validates :title, :catagory_id, presence: true
end
