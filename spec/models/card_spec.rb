require 'spec_helper'

describe Card do
  context 'generating reoder function' do
    card_json = {
      '0' => {
        id: 3,
        catagory_id: 13,
        sort_idx: 0
      },
      '1' => {
        id: 2,
        catagory_id: 13,
        sort_idx: 1
      },
      '2' => {
        id: 1,
        catagory_id: 14,
        sort_idx: 3
      }

    }
    reorder = Card.generate_reorder(card_json , 1)

    it 'should create a SQL function' do
      reorder.should include('CREATE FUNCTION')
    end
    
    it 'should format SQL function name correctly' do
      reorder.should =~ /reorder\_\d\_\w{16}(\s|\()/
    end
    
    it 'should call the function' do
      reorder.should include ('SELECT reorder')
    end
    
    it 'should drop the function' do
      reorder.should include ('DROP FUNCTION reorder')
    end
    
    it 'should have an equal number of parameters to included ids' do
      parameters = reorder.scan(/var\d\sinteger/)
      ids = (reorder.scan(/IN\s\(.*\)/)[0] || "").scan(/var\d/)
      
      expect(parameters.count).to eq(ids.count)
    end
    
    it 'should have CASEs equal to twice number of paramters' do
      parameters = reorder.scan(/var\d\sinteger/)
      cases_num = (reorder.scan(/\(\s?case\s.*\send\s?\)/)[0] || "").scan(/(when|else)/).count
      
      expect(parameters.count * 2).to eq(cases_num)
    end
  end
end