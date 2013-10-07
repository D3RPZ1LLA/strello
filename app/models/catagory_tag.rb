class CatagoryTag < ActiveRecord::Base
  attr_accessible :card_id, :catagory_id

  belongs_to :card,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id

  belongs_to :catagory,
  class_name: "Catagory",
  foreign_key: :catagory_id,
  primary_key: :id

  validates_presence_of :card_id, :catagory_id
  validates :catagory_id, uniqueness: { scope: :card_id }
end
