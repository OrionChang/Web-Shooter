require 'test_helper'

class WebshotsControllerTest < ActionController::TestCase
  setup do
    @webshot = webshots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:webshots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create webshot" do
    assert_difference('Webshot.count') do
      post :create, webshot: { desc: @webshot.desc, photo: @webshot.photo, title: @webshot.title, url: @webshot.url, user_id: @webshot.user_id }
    end

    assert_redirected_to webshot_path(assigns(:webshot))
  end

  test "should show webshot" do
    get :show, id: @webshot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @webshot
    assert_response :success
  end

  test "should update webshot" do
    patch :update, id: @webshot, webshot: { desc: @webshot.desc, photo: @webshot.photo, title: @webshot.title, url: @webshot.url, user_id: @webshot.user_id }
    assert_redirected_to webshot_path(assigns(:webshot))
  end

  test "should destroy webshot" do
    assert_difference('Webshot.count', -1) do
      delete :destroy, id: @webshot
    end

    assert_redirected_to webshots_path
  end
end
