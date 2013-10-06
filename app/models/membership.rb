class Membership < ActiveRecord::Base
  attr_accessible :user_id, :board_id, :admin
  
  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  
  belongs_to :board,
  class_name: "Board",
  foreign_key: :board_id,
  primary_key: :id
end
