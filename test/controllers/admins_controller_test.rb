require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get enterprises" do
    get admins_enterprises_url
    assert_response :success
  end

  test "should get advisers" do
    get admins_advisers_url
    assert_response :success
  end

end
