require "test_helper"

class RedemptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get redemptions_index_url
    assert_response :success
  end

  test "should get create" do
    get redemptions_create_url
    assert_response :success
  end

  test "should get show" do
    get redemptions_show_url
    assert_response :success
  end

  test "should get edit" do
    get redemptions_edit_url
    assert_response :success
  end

  test "should get update" do
    get redemptions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get redemptions_destroy_url
    assert_response :success
  end
end
