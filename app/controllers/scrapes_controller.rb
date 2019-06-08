class ScrapesController < ApplicationController
  def create
    @link = Scraper.scrape(params[:url])
    @post = Post.new(
      link_title: @link[:title],
      link_description: @link[:description],
      link_image: @link[:image],
      link_url: @link[:url],
      link_video: @link[:video]
    )
  end
end
