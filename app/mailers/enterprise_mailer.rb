class EnterpriseMailer < ApplicationMailer
  require 'mailjet'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enterprise_mailer.account_activation.subject
  #
  def account_activation(user, name)
    @user = user
    @name = name
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enterprise_mailer.password_reset.subject
  #
  def password_reset(password_request)
    @password_request = password_request
    mail to: password_request.user.email, subject: "Password Recovery"
  end
end
