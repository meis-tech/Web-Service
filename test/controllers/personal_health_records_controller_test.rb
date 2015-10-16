require 'test_helper'

class PersonalHealthRecordsControllerTest < ActionController::TestCase
  setup do
    @personal_health_record = personal_health_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_health_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_health_record" do
    assert_difference('PersonalHealthRecord.count') do
      post :create, personal_health_record: {  }
    end

    assert_redirected_to personal_health_record_path(assigns(:personal_health_record))
  end

  test "should show personal_health_record" do
    get :show, id: @personal_health_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_health_record
    assert_response :success
  end

  test "should update personal_health_record" do
    patch :update, id: @personal_health_record, personal_health_record: {  }
    assert_redirected_to personal_health_record_path(assigns(:personal_health_record))
  end

  test "should destroy personal_health_record" do
    assert_difference('PersonalHealthRecord.count', -1) do
      delete :destroy, id: @personal_health_record
    end

    assert_redirected_to personal_health_records_path
  end
end
