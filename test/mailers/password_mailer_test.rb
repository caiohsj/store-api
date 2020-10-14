require 'test_helper'

class PasswordMailerTest < ActionMailer::TestCase
  test "send_new_password_mailer" do
    mail = PasswordMailer.send_new_password_mailer
    assert_equal "Send new password mailer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
