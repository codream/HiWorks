require 'test_helper'

class KnockControllerTest < ActionController::TestCase
  test "should get clock_in" do
    get :clock_in
    assert_response :success
  end

  test "should get clock_out" do
    get :clock_out
    assert_response :success
  end

  test "should get modify_clock_in" do
    get :modify_clock_in
    assert_response :success
  end

end
