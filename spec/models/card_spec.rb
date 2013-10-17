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
    
    it 'should match sort_idx cases correctly with json' do
      case_string = reorder
        .scan(/sort\_idx\s?\=\s?\(\s?case\s[when\sid\s?\=\s?\d+\sthen\s\d+\s?|else\s\d+\s?]*\send\s?\)/)
        .first
        .split(/(when|else)/)
        
      cases = {}
      case_string.each do |parse_string|
        next unless parse_string =~ /\d/
        situation = parse_string.scan(/id\s?\=\s?\d/)
        situation = situation.empty? ? 'default' : situation[0].scan(/\d+/)[0].to_i
        
        unless situation == 'default'
          cases[situation] = parse_string.scan(/then\s\d+/)[0].scan(/\d+/)[0].to_i
        else
          cases[situation] = parse_string.scan(/\d+\send/)[0].scan(/\d+/)[0].to_i
        end
      end
      
      matched_cases = card_json.values.map do |card_params|
        if !!cases[card_params[:id]]
          cases[card_params[:id]] == card_params[:sort_idx]
        else
          cases['default'] == card_params[:sort_idx]
        end
      end
      
      expect(matched_cases.all? { |matched| matched == true }).to eq(true)
    end
    
    it 'should match catagory_id cases correctly with json' do
      case_string = reorder
        .scan(/catagory\_id\s?\=\s?\(\s?case\s[when\sid\s?\=\s?\d+\sthen\s\d+\s?|else\s\d+\s?]*\send\s?\)/)
        .first
        .split(/(when|else)/)
        
      cases = {}
      case_string.each do |parse_string|
        next unless parse_string =~ /\d/
        situation = parse_string.scan(/id\s?\=\s?\d/)
        situation = situation.empty? ? 'default' : situation[0].scan(/\d+/)[0].to_i
        
        unless situation == 'default'
          cases[situation] = parse_string.scan(/then\s\d+/)[0].scan(/\d+/)[0].to_i
        else
          cases[situation] = parse_string.scan(/\d+\send/)[0].scan(/\d+/)[0].to_i
        end
      end
      
      matched_cases = card_json.values.map do |card_params|
        if !!cases[card_params[:id]]
          cases[card_params[:id]] == card_params[:catagory_id]
        else
          cases['default'] == card_params[:catagory_id]
        end
      end
      
      expect(matched_cases.all? { |matched| matched == true }).to eq(true)
    end
  end
end