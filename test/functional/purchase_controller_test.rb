require 'test_helper'

class PurchaseControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get complete" do
    get :complete
    assert_response :success
  end

end
