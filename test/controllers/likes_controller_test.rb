require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get like" do
    get likes_like_url
    assert_response :success
  end

  test "should get dislike" do
    get likes_dislike_url
    assert_response :success
  end

end
