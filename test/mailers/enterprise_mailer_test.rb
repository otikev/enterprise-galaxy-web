require 'test_helper'

class EnterpriseMailerTest < ActionMailer::TestCase
  
  test "account_activation" do
    enterprise = enterprises(:foo_inc)
    enterprise.activation_token = Enterprise.new_token
    mail = EnterpriseMailer.account_activation(enterprise)

    assert_equal "Account activation", mail.subject
    assert_equal [enterprise.contact_email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match enterprise.activation_token, mail.body.encoded
  end

end
