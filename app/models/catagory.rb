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
  
  def self.generate_reorder(list_set, user_id)
    function_key = (user_id.to_s) + "_" + (SecureRandom::hex 8)
    
    list_idx = {}
    list_set.values.each do |list_params|
      list_idx[list_params[:id].to_i] = list_params[:sort_idx].to_i
    end
    
    variables = []
    case_statement = []
    
    list_idx.keys.each_with_index do |id, idx|
      if ( idx < list_idx.keys.count - 1 || list_idx.keys.count == 1)
        case_statement << "when id = #{id} then #{list_idx[id]}"
      else
        case_statement << "else #{list_idx[id]}"
      end
      variables << "var#{idx}"
    end
    
    <<-SQL
      CREATE FUNCTION reorder_#{function_key}( #{ variables.map { |var| var + " integer"}.join(', ') } )
      RETURNS void AS
      $$
      UPDATE catagories
      SET sort_idx = (case #{case_statement.join(' ')} end)
      WHERE id IN (#{ variables.join(', ') });
      $$ 
      LANGUAGE SQL;
      
      SELECT reorder_#{function_key}(#{list_idx.keys.map { |id| id.to_s }.join(', ') });
      
      DROP FUNCTION reorder_#{function_key}(#{variables.map { |var| "integer" }.join(', ') });
    SQL
  end
end