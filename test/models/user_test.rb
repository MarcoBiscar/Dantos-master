require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @post = create :post
    @user = create :user
    @goomp = create :goomp
  end

  test "#join goomp" do
    assert_not @user.joined? @goomp

    @user.join @goomp
    assert @user.joined? @goomp

    @user.join @goomp
    assert_not @user.joined? @goomp
  end

  test "founder auto join and can't unjoin his own goomp" do
    goomp = create :goomp, user: @user
    assert @user.joined? @goomp

    @user.join @goomp
    assert @user.joined? @goomp
  end

end
