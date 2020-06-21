class EnterpriseMailer < ApplicationMailer
  require 'mailjet'

  def account_activation(user, name)
    @user = user
    @name = name
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(password_request)
    @password_request = password_request
    mail to: password_request.user.email, subject: "Password Recovery"
  end

  def account_unlock(user, name)
    @user = user
    @name = name
    mail to: user.email, subject: "Account Unlock"
  end
end
