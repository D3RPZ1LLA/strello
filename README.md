Strello
=========
www.strello.herokuapp.com

Clone of the productivity app Trello. Users create "boards" as part of an organization or personally and from there can create "cards" to delegate tasks or notes to other members of the board.

  - Avoids N+1 queries on Card and List reindexing (dragging movements) by generating a custom SQL function per group of alternations to set the new indicies of altered models with a hash. Sending this reindexing request required a custom AJAX call.

  - Utilizes Unobtrusive JavaScript for all form submissions aside from User creation/login to give the appearance of a single page application.
  - Adding new lists causes the Board's width to be recalculated to preserve the lists' floating and horizontal scrolling.
  - The response value of a request to add a Board member is a hash of the User and their avatar url as the url is not accessible from the User model rendered to json.
  - Provides RSpec tests for all Rails models and the Card / List reindexing methods.

Avoiding N+1 Queries; A Unique Solution
----

This is the Catagory factory method to generate a SQL query that when executed will create a SQL function to UPDATE the catagories's index column with a hash mapping catagory ids to their catagory's new index and then destroy it.
  - Note: list_set is a json object with data which lists have been altered and is of the format
  
  [ {id: value, sort_idx: value}, ... ]

```
   def self.generate_reorder(list_set, current_user_id)
    function_key = (current_user_id.to_s) + "_" + (SecureRandom::hex 8)
    
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
```
