class ChecklistItem < ActiveRecord::Base
  attr_accessible :checklist_id, :title

  belongs_to :checklist,
  class_name: "Checklist",
  foreign_key: :checklist_id,
  primary_key: :id

  validates :title, presence: true
end
