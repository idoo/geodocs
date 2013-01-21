require 'test_helper'

class WelcomeAgainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
