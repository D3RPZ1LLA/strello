class Catagory < ActiveRecord::Base
  attr_accessible :board_id, :title

  belongs_to :board,
  class_name: "Board",
  foreign_key: :board_id,
  primary_key: :id

  validates_presence_of :board_id, :title
  validates :title, uniqueness: { scope: :board_id }
end
