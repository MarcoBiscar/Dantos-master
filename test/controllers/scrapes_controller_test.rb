require 'test_helper'

class ScrapesControllerTest < ActionDispatch::IntegrationTest
  test "POST /" do
    url = "https://medium.com/@Stephanbv/elixir-phoenix-lets-code-authentication-todo-application-part-1-599ee94cd04d#.59a9pm1jc"
    VCR.use_cassette("scraper-url-1") do
      post scrapes_url(format: :json), params: { url: url }
    end
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal("Elixir /Phoenix— Lets code authentication. Todo application part 1. — Medium", json["title"])
    assert json["description"]
    assert json["card"]
  end
end
