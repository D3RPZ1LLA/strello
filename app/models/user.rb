require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :bio, :email, :password_digest, :username, :password, :password_verify
  attr_accessor :password, :password_verify

  validates_presence_of :email, :password, :password_verify
  validate :match_passwords, on: :create
  
  after_validation :set_password
  
  private
  def password
    @password ||= BCrypt::Password.new(self.password_digest)
  end
  
  def match_passwords
    errors.add(:password, "must match") unless @password == @password_verify
  end
  
  def set_password
    self.password_digest = BCrypt::Password.create(@password)
  end
end
