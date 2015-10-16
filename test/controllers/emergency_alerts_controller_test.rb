require 'test_helper'

class EmergencyAlertsControllerTest < ActionController::TestCase
  setup do
    @emergency_alert = emergency_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emergency_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emergency_alert" do
    assert_difference('EmergencyAlert.count') do
      post :create, emergency_alert: {  }
    end

    assert_redirected_to emergency_alert_path(assigns(:emergency_alert))
  end

  test "should show emergency_alert" do
    get :show, id: @emergency_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emergency_alert
    assert_response :success
  end

  test "should update emergency_alert" do
    patch :update, id: @emergency_alert, emergency_alert: {  }
    assert_redirected_to emergency_alert_path(assigns(:emergency_alert))
  end

  test "should destroy emergency_alert" do
    assert_difference('EmergencyAlert.count', -1) do
      delete :destroy, id: @emergency_alert
    end

    assert_redirected_to emergency_alerts_path
  end
end
