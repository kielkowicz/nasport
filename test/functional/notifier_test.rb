require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "event_changed" do
    mail = Notifier.event_changed
    assert_equal "Event changed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
