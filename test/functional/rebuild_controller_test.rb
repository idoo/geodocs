require 'test_helper'

class RebuildControllerTest < ActionController::TestCase
  test "should get make" do
    get :make
    assert_response :success
  end

end
