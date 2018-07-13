require 'test_helper'

class ActivatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activate = activates(:one)
  end

  test "should get index" do
    get activates_url
    assert_response :success
  end

  test "should get new" do
    get new_activate_url
    assert_response :success
  end

  test "should create activate" do
    assert_difference('Activate.count') do
      post activates_url, params: { activate: { code: @activate.code, phone: @activate.phone, status: @activate.status } }
    end

    assert_redirected_to activate_url(Activate.last)
  end

  test "should show activate" do
    get activate_url(@activate)
    assert_response :success
  end

  test "should get edit" do
    get edit_activate_url(@activate)
    assert_response :success
  end

  test "should update activate" do
    patch activate_url(@activate), params: { activate: { code: @activate.code, phone: @activate.phone, status: @activate.status } }
    assert_redirected_to activate_url(@activate)
  end

  test "should destroy activate" do
    assert_difference('Activate.count', -1) do
      delete activate_url(@activate)
    end

    assert_redirected_to activates_url
  end
end
