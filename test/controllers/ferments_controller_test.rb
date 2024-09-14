require "test_helper"

class FermentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ferments_index_url
    assert_response :success
  end

  test "should get show" do
    get ferments_show_url
    assert_response :success
  end

  test "should get new" do
    get ferments_new_url
    assert_response :success
  end

  test "should get create" do
    get ferments_create_url
    assert_response :success
  end

  test "should get edit" do
    get ferments_edit_url
    assert_response :success
  end

  test "should get update" do
    get ferments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get ferments_destroy_url
    assert_response :success
  end
end
