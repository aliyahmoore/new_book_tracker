require "test_helper"

class BookClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_clubs_index_url
    assert_response :success
  end

  test "should get show" do
    get book_clubs_show_url
    assert_response :success
  end

  test "should get new" do
    get book_clubs_new_url
    assert_response :success
  end

  test "should get create" do
    get book_clubs_create_url
    assert_response :success
  end

  test "should get edit" do
    get book_clubs_edit_url
    assert_response :success
  end

  test "should get update" do
    get book_clubs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get book_clubs_destroy_url
    assert_response :success
  end
end
