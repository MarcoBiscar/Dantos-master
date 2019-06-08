require 'test_helper'

class SubtopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subtopic = create :subtopic
    @goomp = create :goomp
    @user = create :user
    sign_in @user
 end

  # test "should get index" do
  #   get subtopics_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_subtopic_url
  #   assert_response :success
  # end

  test "should create subtopic" do
    assert_difference('Subtopic.count') do
      post goomp_subtopics_url(@goomp), params: { subtopic: attributes_for(:subtopic) }
    end

    assert_equal @goomp, Subtopic.last.goomp
  end

  # test "should show subtopic" do
  #   get subtopic_url(@subtopic)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_subtopic_url(@subtopic)
  #   assert_response :success
  # end

  # test "should update subtopic" do
  #   patch subtopic_url(@subtopic), params: { subtopic: { goomp_id: @subtopic.goomp_id, name: @subtopic.name } }
  #   assert_redirected_to subtopic_url(@subtopic)
  # end

  # test "should destroy subtopic" do
  #   assert_difference('Subtopic.count', -1) do
  #     delete subtopic_url(@subtopic)
  #   end

  #   assert_redirected_to subtopics_url
  # end
end
