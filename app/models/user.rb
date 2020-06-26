# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  email                 :string
#  password_hash         :string
#  password_salt         :string
#  auth_token            :string
#  activation_token      :string
#  enabled               :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  two_factor            :boolean          default("false")
#  activated_at          :datetime
#  activated             :boolean          default("false")
#  google_secret         :string
#  mfa_secret            :string
#  failed_login_attempts :integer          default("0")
#  unlock_token          :string
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
  validates :email, presence: true, format: { with: Utils::VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5, maximum: 40 }, confirmation: true

  acts_as_google_authenticated lookup_token: :mfa_secret, encrypt_secrets: true, issuer: 'enterprisegalaxy.com'

  def is_enterprise?
    enterprise != nil
  end

  def is_adviser?
    adviser != nil
  end

  def profile_completion_status
    if is_adviser?
      adviser.profile_completion_status
    elsif is_enterprise?
      enterprise.profile_completion_status
    end
  end

  def two_factor(code)
    self.password = 'somepassword' # prevent password validation from failing
    self.mfa_secret = code
    save!
    if google_authentic?(code)
      generate_auth_token
      update_attribute(:auth_token, auth_token)
      self
    end
  end

  def authenticate(pass)
    puts 'Authenticating....'

    if BCrypt::Password.new(password_hash).is_password?(pass + password_salt)
      puts 'password is valid'
      generate_auth_token
      update_attribute(:failed_login_attempts, 0)
      update_attribute(:auth_token, auth_token)
      if two_factor?
        self.password = pass # prevent password validation from failing
        set_google_secret unless google_secret
      end
      self
    else
      update_attribute(:failed_login_attempts, failed_login_attempts + 1)
      if failed_login_attempts >= 3
        update_attribute(:unlock_token, User.digest(User.new_token))
        update_attribute(:enabled, false)

        if is_enterprise?
          EnterpriseMailer.account_unlock(self, enterprise.business_name).deliver_now
        elsif is_adviser?
          EnterpriseMailer.account_unlock(self, adviser.first_name).deliver_now
        end
      end
      nil
    end
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")

    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def change_password(password)
    self.password = password
    self.password_salt = Utils.random_string(10)
    self.password_hash = User.digest(self.password + password_salt)
    save!
  end

  private

  def set_password
    self.password_salt = Utils.random_string(10)
    self.password_hash = User.digest(password + password_salt)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def downcase_email
    email.downcase
  end

  def create_activation_digest
    self.enabled = true
    self.activated = false
    self.activation_token = User.digest(User.new_token)
  end

  def generate_auth_token
    begin
      self.auth_token = Digest::SHA1.hexdigest(User.digest(User.new_token))
    end while User.exists?(auth_token: auth_token)
  end
end
