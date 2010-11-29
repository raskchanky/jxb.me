require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  setup do
    @site = Site.create :url => 'http://google.com'
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post :create, :site => @site.attributes
    end

    assert_redirected_to site_path(assigns(:site))
  end

  test "should show site" do
    get :show, :id => @site.to_param
    assert_response :success
  end

  test "short url should redirect" do
    get :go, :url => @site.short_url
    assert_redirected_to @site.url
  end

  test "long url should redirect" do
    get :go, :url => @site.long_url
    assert_redirected_to @site.url
  end

  test "should redirect to not_found if the url is invalid" do
    get :go, :url => @site.short_url.reverse
    assert_template 'not_found'
  end
end
