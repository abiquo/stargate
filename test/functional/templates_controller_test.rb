require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  test "should get sync" do
    get :sync
    assert_response :success
  end

end
