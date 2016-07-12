require 'test_helper'

class DownloadTicketsControllerTest < ActionController::TestCase
  setup do
    @download_ticket = download_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:download_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create download_ticket" do
    assert_difference('DownloadTicket.count') do
      post :create, download_ticket: {  }
    end

    assert_redirected_to download_ticket_path(assigns(:download_ticket))
  end

  test "should show download_ticket" do
    get :show, id: @download_ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @download_ticket
    assert_response :success
  end

  test "should update download_ticket" do
    patch :update, id: @download_ticket, download_ticket: {  }
    assert_redirected_to download_ticket_path(assigns(:download_ticket))
  end

  test "should destroy download_ticket" do
    assert_difference('DownloadTicket.count', -1) do
      delete :destroy, id: @download_ticket
    end

    assert_redirected_to download_tickets_path
  end
end
