class User < ActiveRecord::Base
  attr_accessible :bio, :email, :password_digest, :username

  validates_presence_of :email, :password_digest

  def password
    @password ||= BCrypt::Password.new(self.password_digest)
  end

  def password=(new_password)
    self.password_digeset = BCrypt::Password(new_password)
  end
end
