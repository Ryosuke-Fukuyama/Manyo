require 'test_helper'

class TsksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tsks_index_url
    assert_response :success
  end

  test "should get show" do
    get tsks_show_url
    assert_response :success
  end

  test "should get new" do
    get tsks_new_url
    assert_response :success
  end

  test "should get edit" do
    get tsks_edit_url
    assert_response :success
  end

  test "should get _form" do
    get tsks__form_url
    assert_response :success
  end

end
