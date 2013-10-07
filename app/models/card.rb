class Card < ActiveRecord::Base
  attr_accessible :description, :due_date, :start_date, :title, :catagory_id
  
  validates_presence_of :description, :due_date, :start_date, :title
  
  belongs_to :catagory,
  class_name: "Catagory",
  foreign_key: :catagory_id,
  primary_key: :id
end
