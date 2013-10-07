class Card < ActiveRecord::Base
  attr_accessible :description, :due_date, :start_date, :title, :catagory_id
  
  validates_presence_of :description, :due_date, :start_date, :title, :catagory_id
  
  belongs_to :catagory,
  class_name: "Catagory",
  foreign_key: :catagory_id,
  primary_key: :id
  
  has_many :checklist_items,
  class_name: "ChecklistItem",
  foreign_key: :card_id,
  primary_key: :id
end
