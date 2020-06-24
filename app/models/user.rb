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
#  two_factor            :boolean          default("true")
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
  has_one :admin

  accepts_nested_attributes_for :enterprise
  accepts_nested_attributes_for :adviser

  before_save :downcase_email
  before_create :create_activation_digest, :set_password

  attr_accessor :password, :remember_me
  validates :email, presence: true, format: { with: Utils::VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :password, :presence =>true,:length => { :minimum => 5, :maximum => 40 },:confirmation =>true

  acts_as_google_authenticated :lookup_token => :mfa_secret, :encrypt_secrets => true

  def is_enterprise?
    self.enterprise != nil
  end

  def is_adviser?
    self.adviser != nil
  end

  def is_admin?
    self.admin != nil
  end

  def profile_completion_status
    if is_adviser?
      self.adviser.profile_completion_status
    elsif is_enterprise?
      self.enterprise.profile_completion_status
    end
  end
  def two_factor(code)
    self.password = "somepassword" #prevent password validation from failing
    self.mfa_secret = code
    self.save!
    if self.google_authentic?(code)
      generate_auth_token
      self.update_attribute(:auth_token, self.auth_token)
      self
    else
      nil
    end
  end

  def authenticate(pass)
    puts "Authenticating...."

    if BCrypt::Password.new(self.password_hash).is_password?(pass + self.password_salt)
      puts "password is valid"
      generate_auth_token
      self.update_attribute(:failed_login_attempts,0)
      self.update_attribute(:auth_token, self.auth_token)
      if self.two_factor?
        self.password = pass #prevent password validation from failing
        unless self.google_secret
          set_google_secret
        end
      end
      self
    else
      update_attribute(:failed_login_attempts,self.failed_login_attempts+1)
      if self.failed_login_attempts >= 3
        self.update_attribute(:unlock_token,User.digest(User.new_token))
        self.update_attribute(:enabled,false)

        if is_enterprise?
          EnterpriseMailer.account_unlock(self, self.enterprise.business_name).deliver_now
        elsif is_adviser?
          EnterpriseMailer.account_unlock(self, self.adviser.first_name).deliver_now
        end
      end
      nil
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

  def change_password(password)
    self.password = password
    self.password_salt = Utils.random_string(10)
    self.password_hash = User.digest(self.password + self.password_salt)
    self.save!
  end

  private

  def set_password
    self.password_salt = Utils.random_string(10)
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
    self.enabled = true
    self.activated = false
    self.activation_token = User.digest(User.new_token)
  end

  def generate_auth_token
    begin
      self.auth_token = Digest::SHA1.hexdigest(User.digest(User.new_token))
    end while User.exists?(:auth_token => self.auth_token)
  end
end
