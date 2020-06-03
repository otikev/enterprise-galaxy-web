# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string
#  password_hash           :string
#  password_salt           :string
#  auth_token              :string
#  activated               :string
#  activation_token        :string
#  activation_token_expiry :date
#  enabled                 :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  two_factor              :boolean          default("false")
#

class User < ApplicationRecord
  require 'utils'

  has_one :enterprise
  has_one :adviser

  accepts_nested_attributes_for :enterprise
  accepts_nested_attributes_for :adviser

  before_save :downcase_email
  before_create :create_activation_digest, :set_password

  attr_accessor :password, :remember_me
  validates :email, presence: true, format: { with: Utils::VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :password, :presence =>true,:length => { :minimum => 5, :maximum => 40 },:confirmation =>true

  def send_activate
    #Don't send activation emails if user already activated
    if !activated
      update_attribute('activation_token_expiry', (Date.today + 7.days))
      Notifications.delay.activate(self)
    end
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def set_password
    self.password_salt = Utils.random_string(10) if !self.password_salt?
    self.password_hash = User.digest(password + self.password_salt)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def downcase_email
    email.downcase
  end

  def create_activation_digest
    self.activation_token = User.digest(User.new_token)
  end

  def generate_auth_token
    begin
      self.auth_token = Digest::SHA1.hexdigest(Utils.random_string(10))
    end while User.exists?(:auth_token => self.auth_token)
  end
end
