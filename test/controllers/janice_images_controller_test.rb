require "test_helper"

class JaniceImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @janice_image = janice_images(:one)
  end

  test "should get index" do
    get janice_images_url, as: :json
    assert_response :success
  end

  test "should create janice_image" do
    assert_difference("JaniceImage.count") do
      post janice_images_url, params: { janice_image: { date: @janice_image.date, url: @janice_image.url } }, as: :json
    end

    assert_response :created
  end

  test "should show janice_image" do
    get janice_image_url(@janice_image), as: :json
    assert_response :success
  end

  test "should update janice_image" do
    patch janice_image_url(@janice_image), params: { janice_image: { date: @janice_image.date, url: @janice_image.url } }, as: :json
    assert_response :success
  end

  test "should destroy janice_image" do
    assert_difference("JaniceImage.count", -1) do
      delete janice_image_url(@janice_image), as: :json
    end

    assert_response :no_content
  end
end
