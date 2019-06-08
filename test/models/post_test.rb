require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = create :post
    @user = create :user
  end

  test "#liked_by" do
    @post.liked_by @user
    assert @post.reload.liked_by?(@user)
  end

  test "#liked_by unlike" do
    @post.liked_by @user
    @post.liked_by @user
    assert_not @post.reload.liked_by?(@user)
  end

  test "#liked_by nil should not raise error" do
    assert_nothing_raised do
      assert_not @post.liked_by?(nil)
    end
  end

  test "#liked_by?" do
    @post.liked_by @user
    assert @post.liked_by?(@user)
  end
end
