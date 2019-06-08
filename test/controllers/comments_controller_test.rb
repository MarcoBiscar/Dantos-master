require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = create :comment
    @post = create :post
    @user = create :user
    sign_in @user
  end

  test "should like" do
    post like_comment_url(@comment), xhr: true
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_url(@post), params: { comment: attributes_for(:comment) }
    end

    assert_equal @post, Comment.last.post
  end

#   test "should show comment" do
#     get comment_url(@comment)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_comment_url(@comment)
#     assert_response :success
#   end

#   test "should update comment" do
#     patch comment_url(@comment), params: { comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id } }
#     assert_redirected_to comment_url(@comment)
#   end

#   test "should destroy comment" do
#     assert_difference('Comment.count', -1) do
#       delete comment_url(@comment)
#     end

#     assert_redirected_to comments_url
#   end
end
