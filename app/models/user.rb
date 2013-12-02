require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :token, :bio, :email, :password_digest, :full_name,
    :initials, :username, :password, :password_verify, :avatar
     
  has_attached_file :avatar, styles: {
    big: '170x170#',
    thumb: '34x34#' 
  }
     
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

  validates :email, presence: true
  validate :email_formatted
  validates :password, :password_verify, presence: true, on: :create
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validate :match_passwords, on: :create

  after_validation :set_password, on: :create
  after_validation :set_token, on: :create

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
  
  def email_formatted
    errors.add(:email, "invalid email") unless self.email =~ /^[A-Za-z0-9.\-]*\@[A-Za-z0-9.]*\.[A-Za-z]*$/
  end

  def set_password
    self.password_digest = BCrypt::Password.create(@password)
  end
end
