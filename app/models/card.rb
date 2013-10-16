class Card < ActiveRecord::Base
  attr_accessible :description, :due_date, :start_date, :title, :catagory_id, :sort_idx

  belongs_to :catagory,
  class_name: "Catagory",
  foreign_key: :catagory_id,
  primary_key: :id

  has_one :board, through: :catagory, source: :board

  has_many :members, through: :board, source: :members

  has_many :checklists,
  class_name: "Checklist",
  foreign_key: :card_id,
  primary_key: :id
  
  has_many :checklist_items, through: :checklists, source: :checklist_items

  has_many :participations,
  inverse_of: :card,
  class_name: "Participation",
  foreign_key: :card_id,
  primary_key: :id

  has_many :participants, through: :participations, source: :user

  validates :title, :catagory_id, presence: true
  
  def self.generate_reorder(card_set, user_id)
    function_key = (user_id.to_s) + "_" + (SecureRandom::hex 8)
  
    
    
    <<-SQL
      CREATE FUNCTION reorder_#{function_key}( #{ variables.map { |var| var + " integer"}.join(', ') } )
      RETURNS void AS
      $$
      UPDATE catagories
      SET sort_idx = (case #{case_statement.join(' ')} end)
      WHERE id IN ( #{ variables.join(', ') } );
      $$ 
      LANGUAGE SQL;
      
      SELECT reorder_#{function_key}(#{cat_idx.keys.map { |id| id.to_s }.join(', ') });
      
      DROP FUNCTION reorder_#{function_key}(#{variables.map { |var| "integer" }.join(', ') });
    SQL
  end
end
