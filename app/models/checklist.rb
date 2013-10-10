class Checklist < ActiveRecord::Base
  attr_accessible :card_id, :title

  belongs_to :card,
  class_name: "Card",
  foreign_key: :card_id,
  primary_key: :id
end
