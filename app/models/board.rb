class Board < ActiveRecord::Base
  attr_accessible :title, :creator_id
  
  validates_presence_of :title, :creator_id
  
  belongs_to :creator,
  inverse_of: :created_boards,
  class_name: "User",
  foreign_key: :creator_id,
  primary_key: :id
  
  has_many :memberships,
  class_name: "Membership",
  foreign_key: :board_id,
  primary_key: :id
  
  has_many :members, through: :memberships, source: :user
  
  has_many :catagories,
  class_name: "Catagory",
  foreign_key: :board_id,
  primary_key: :id
  
  has_many :cards, through: :catagories, source: :cards
end
