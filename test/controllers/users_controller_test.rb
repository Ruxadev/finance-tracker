require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_portifolio" do
    get users_my_portifolio_url
    assert_response :success
  end
end
