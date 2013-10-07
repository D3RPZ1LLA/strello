class Participation < ActiveRecord::Base
  attr_accessible :card_id, :user_id
  
  validates_presence_of :card_id, :user_id
  validates :user_id, uniqueness: { scope: :card_id }
end
