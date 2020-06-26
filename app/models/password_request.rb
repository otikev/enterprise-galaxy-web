# == Schema Information
#
# Table name: password_requests
#
#  id         :integer          not null, primary key
#  token      :string
#  expiry     :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  used       :boolean          default("false")
#

class PasswordRequest < ApplicationRecord
  require 'utils'
  belongs_to :user

  validates :user, presence: true
  validates :expiry, presence: true
  validates :token, presence: true

  attr_accessor :password, :password_confirmation

  def change_password(password, password_confirmation)
    if password == password_confirmation
      user.change_password(password)
      if user.errors.any?
        user.errors.each do |k, v|
          errors.add(k, v)
        end
      else
        self.used = true
        save
      end
    else
      errors.add(:base, 'The password and password confirmation do not match!')
    end
  end

  def self.delete_expired_requests
    now = DateTime.current
    requests = PasswordRequest.where('expiry < ?', now)
    count = requests.count
    requests.delete_all
    count
  end

  def self.send_password_reset(email)
    success = false
    user = User.where(email: email).first
    if user
      puts 'found user with email ' + email
      begin
        request_pwd = PasswordRequest.new
        request_pwd.user = user
        request_pwd.token = Digest::SHA1.hexdigest(Utils.random_upcase_string(10))
        request_pwd.expiry = (DateTime.current + 24.hours).to_datetime
        request_pwd.save!

        puts 'sending password recovery email...'
        EnterpriseMailer.password_reset(request_pwd).deliver_now
        success = true
      rescue Exception => e
        success = false
        logger.error e.message
        e.backtrace.each { |line| logger.error line }
      end
    else
      success = false
    end
    success
  end
end
