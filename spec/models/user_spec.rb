require 'spec_helper'

describe User do
  context 'new user' do 
    
    it 'should create a new user with valid credientials' do
      konata = User.new(
        email: 'izumi.konata@gmail.com',
        password: 'awesome',
        password_verify: 'awesome'
      )
      
      expect(konata).to be_valid
    end
    
    it 'should not validate missing email' do
      konata = User.new(
        password: 'awesome',
        password_verify: 'awesome'
      )
      
      expect(konata).to_not be_valid
    end
    
    it 'should not validate poorly formatted email' do      
      konata = User.new(
        email: 'omlympics.fail',
        password: 'awesome',
        password_verify: 'awesome'
      )
      
      expect(konata).to_not be_valid
    end
    
    it 'should not validate missing password' do 
      konata = User.new(
        email: 'izumi.konata@gmail.com',
        password_verify: 'awesome'
      )
      
      expect(konata).to_not be_valid
    end
    
    it 'should not validate too short password' do
      konata = User.new(
        email: 'izumi.konata@gmail.com',
        password: 'combo',
        password_verify: 'combo'
      )
      
      expect(konata).to_not be_valid
    end
    
    it 'should not validate too long password' do
      konata = User.new(
        email: 'izumi.konata@gmail.com',
        password: '123456789101112131415',
        password_verify: '123456789101112131415'
      )
      
      expect(konata).to_not be_valid
    end
  end 
end