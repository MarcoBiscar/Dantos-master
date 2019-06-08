require 'test_helper'

class ScraperTest < ActiveSupport::TestCase
  test "#scrape #1" do
    url = "https://medium.com/@Stephanbv/elixir-phoenix-lets-code-authentication-todo-application-part-1-599ee94cd04d#.59a9pm1jc"
    json = {}
    VCR.use_cassette("scraper-url-1") do
      json = Scraper.scrape(url)
    end
    assert_equal("Elixir /Phoenix— Lets code authentication. Todo application part 1. – Medium", json[:title])
  end

  test "#scrape #2" do
    url = "http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations"
    json = {}
    VCR.use_cassette("scraper-url-2") do
      json = Scraper.scrape(url)
    end
    assert_equal("Active Record Query Interface — Ruby on Rails Guides", json[:title])
  end

  test "#scrape youtube 1" do
    url = "https://www.youtube.com/watch?v=nrEALqTDQwQ"
    json = {}
    VCR.use_cassette("scraper-url-youtube-1") do
      json = Scraper.scrape(url)
    end
    assert_equal(%Q(The Beatles  " It's For You " - YouTube), json[:title])
    assert_equal(%Q(<iframe width="557" height="270" src="https://www.youtube.com/embed/nrEALqTDQwQ?feature=oembed&autoplay=1" frameborder="0" allowfullscreen></iframe>), json[:video])
  end
end
