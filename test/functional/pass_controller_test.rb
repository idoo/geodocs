require 'test_helper'

class PassControllerTest < ActionController::TestCase
  test "should get update_password" do
    get :update_password
    assert_response :success
  end

end
