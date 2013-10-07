class Catagory < ActiveRecord::Base
  attr_accessible :board_id, :title
  
  validates_presence_of :board_id, :title
  validates :title, uniqueness: { scope: :board_id }
  
  belongs_to :board,
  class_name: "Board",
  foreign_key: :board_id,
  primary_key: :id
  
  has_many :cards,
  class_name: "Card",
  foreign_key: :catagory_id,
  primary_key: :id
end
