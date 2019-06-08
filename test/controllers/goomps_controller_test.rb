require 'test_helper'

class GoompsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goomp = create :goomp
    @user = create :user
    sign_in @user

    @stripe_params = {
      "id"=>"122",
      "object"=>"token",
      "card"=>{
        "id"=>"card_92dZL6EKa96FG9",
        "object"=>"card",
        "address_city"=>"",
        "address_country"=>"",
        "address_line1"=>"",
        "address_line1_check"=>"",
        "address_line2"=>"",
        "address_state"=>"",
        "address_zip"=>"",
        "address_zip_check"=>"",
        "brand"=>"Visa",
        "country"=>"US",
        "cvc_check"=>"pass",
        "dynamic_last4"=>"",
        "exp_month"=>"11",
        "exp_year"=>"2019",
        "funding"=>"credit",
        "last4"=>"4242",
        "name"=>"aceat8848@gmail.com",
        "tokenization_method"=>""
      },
      "client_ip"=>"123.146.42.232",
      "created"=>"1471694960",
      "email"=>"aceat8848@gmail.com",
      "livemode"=>"false",
      "type"=>"card",
      "used"=>"false"
    }
  end

  test "should get index" do
    get goomps_url
    assert_response :success
  end

  test "should get new" do
    get new_goomp_url
    assert_response :success
  end

  test "should create and auto-join goomp" do
    assert_difference('Goomp.count') do
      post goomps_url, params: { goomp: attributes_for(:goomp) }
    end
    new_goomp = Goomp.last

    assert @user.joined? new_goomp
    assert_redirected_to goomp_url(new_goomp)
  end

  test "join premium goomp" do
    post join_goomp_url(@goomp), params: @stripe_params
  end

  test "should show goomp" do
    get goomp_url(@goomp)
    assert_response :success
  end

  test "should get edit" do
    get edit_goomp_url(@goomp)
    assert_response :success
  end

  test "should update goomp" do
    patch goomp_url(@goomp), params: { goomp: attributes_for(:goomp) }
    assert_redirected_to goomp_url(@goomp)
  end

  test "should destroy goomp" do
    assert_difference('Goomp.count', -1) do
      delete goomp_url(@goomp)
    end

    assert_redirected_to goomps_url
  end
end
