require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :token, :bio, :email, :password_digest, :username, :password, :password_verify
  attr_accessor :password, :password_verify

  has_many :created_boards,
  inverse_of: :creator,
  class_name: "Board",
  foreign_key: :creator_id,
  primary_key: :id

  has_many :memberships,
  class_name: "Membership",
  foreign_key: :user_id,
  primary_key: :id

  has_many :member_boards, through: :memberships, source: :board

  has_many :participations,
  class_name: "Participation",
  foreign_key: :user_id,
  primary_key: :id

  has_many :cards, through: :participations, source: :card

  validates_presence_of :email
  validates_presence_of :password, :password_verify, on: :create
  validate :match_passwords, on: :create

  after_validation :set_password, on: :create
  after_validation :set_token

  def self.generate_token
    SecureRandom::urlsafe_base64 16
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return user && BCrypt::Password.new(user.password_digest).is_password?(password) ? user : nil
  end

  def set_token
    self.token = User.generate_token
  end

  private
  def match_passwords
    errors.add(:password, "must match") unless @password == @password_verify
  end

  def set_password
    self.password_digest = BCrypt::Password.create(@password)
  end
end
