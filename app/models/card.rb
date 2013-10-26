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
  
    card_idx = {}
    card_set.values.each do |card_params|
      card_idx[card_params[:id].to_i] = {
        catagory_id: card_params[:catagory_id].to_i,
        sort_idx: card_params[:sort_idx].to_i
      }
    end
    
    variables = []
    case_state_idx = []
    case_state_catagory = []
    
    card_idx.keys.each_with_index do |id, idx|
      if (idx < card_idx.keys.count - 1 || card_idx.keys.count == 1)
        case_state_idx << "when id = #{id} then #{card_idx[id][:sort_idx]}"
        case_state_catagory << "when id = #{id} then #{card_idx[id][:catagory_id]}"        
      else
        case_state_idx << "else #{card_idx[id][:sort_idx]}"
        case_state_catagory << "else #{card_idx[id][:catagory_id]}"
      end
      variables << "var#{idx}"
    end
    
    <<-SQL
      CREATE FUNCTION reorder_#{function_key}( #{ variables.map { |var| var + " integer"}.join(', ') } )
      RETURNS void AS
      $$
      UPDATE cards
      SET sort_idx = (case #{case_state_idx.join(' ')} end), catagory_id = (case #{case_state_catagory.join(' ')} end)
      WHERE id IN ( #{ variables.join(', ') } );
      $$ 
      LANGUAGE SQL;
      
      SELECT reorder_#{function_key}(#{card_idx.keys.map { |id| id.to_s }.join(', ') });
      
      DROP FUNCTION reorder_#{function_key}(#{variables.map { |var| "integer" }.join(', ') });
    SQL
  end
  
  def can_edit?(user)
    
  end
end
