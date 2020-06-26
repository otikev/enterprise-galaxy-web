# Preview all emails at http://localhost:3000/rails/mailers/enterprise_mailer
class EnterpriseMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/enterprise_mailer/account_activation
  def account_activation
    enterprise = Enterprise.first
    enterprise.activation_token = Enterprise.new_token
    EnterpriseMailer.account_activation(enterprise)
  end

  # Preview this email at http://localhost:3000/rails/mailers/enterprise_mailer/password_reset
  def password_reset
    EnterpriseMailer.password_reset
  end
end
