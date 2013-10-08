class ChecklistItem < ActiveRecord::Base
  attr_accessible :card_id, :title

  belongs_to :card,
  inverse_of: :checklist_items,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id

  validates :title, presence: true
end
