require 'test_helper'

class UsersMailerTest < ActionMailer::TestCase
  test "reset_email" do
    mail = UsersMailer.reset_email
    assert_equal "Reset email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
