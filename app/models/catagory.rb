class Catagory < ActiveRecord::Base
  attr_accessible :board_id, :title, :sort_idx

  belongs_to :board,
  class_name: "Board",
  foreign_key: :board_id,
  primary_key: :id

  has_many :cards,
  class_name: "Card",
  foreign_key: :catagory_id,
  primary_key: :id

  validates :board_id, :title, :sort_idx, presence: true
  validates :title, uniqueness: { scope: :board_id }
end
