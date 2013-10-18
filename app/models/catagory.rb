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
  
  def self.generate_reorder(catagory_set, user_id)
    function_key = (user_id.to_s) + "_" + (SecureRandom::hex 8)
    
    cat_idx = {}
    catagory_set.values.each do |catagory_params|
      cat_idx[catagory_params[:id].to_i] = catagory_params[:sort_idx].to_i
    end
    
    variables = []
    case_statement = []
    
    cat_idx.keys.each_with_index do |id, idx|
      if ( idx < cat_idx.keys.count - 1 || cat_idx.keys.count == 1)
        case_statement << "when id = #{id} then #{cat_idx[id]}"
      else
        case_statement << "else #{cat_idx[id]}"
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
      
      SELECT reorder_#{function_key}(#{cat_idx.keys.map { |id| id.to_s }.join(', ') });
      
      DROP FUNCTION reorder_#{function_key}(#{variables.map { |var| "integer" }.join(', ') });
    SQL
  end
end