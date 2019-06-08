require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "process_command" do
    msg = create :message, body: "/charge $99.1"
    assert_match 'data-amount="9910"', msg.attachment.html
    assert_equal nil, msg.body
  end
end
