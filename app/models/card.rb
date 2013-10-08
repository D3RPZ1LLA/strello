class Card < ActiveRecord::Base
  attr_accessible :description, :due_date, :start_date, :title, :board_id

  has_many :catagory_taggings,
  class_name: "CatagoryTag",
  foreign_key: :card_id,
  primary_key: :id

  has_many :catagories, through: :catagory_taggings, source: :catagory

  has_many :checklist_items,
  inverse_of: :card,
  class_name: "ChecklistItem",
  foreign_key: :card_id,
  primary_key: :id

  belongs_to :board,
  class_name: "Board",
  foreign_key: :board_id,
  primary_key: :id

  has_many :participations,
  class_name: "Participation",
  foreign_key: :card_id,
  primary_key: :id

  has_many :participants, through: :participations, source: :user

  validates_presence_of :due_date, :start_date, :title, :board_id
end
