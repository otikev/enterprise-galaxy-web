class EnterpriseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enterprise_mailer.account_activation.subject
  #
  def account_activation(enterprise)
    @enterprise = enterprise

    mail to: enterprise.contact_email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enterprise_mailer.password_reset.subject
  #
  def password_reset
  end
end
