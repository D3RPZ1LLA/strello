class Checklist < ActiveRecord::Base
  attr_accessible :card_id, :title

  belongs_to :card,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id

  has_many :checklist_items,
  class_name: "ChecklistItem",
  foreign_key: :checklist_id,
  primary_key: :id

  validates :card_id, :title, presence: true
end
