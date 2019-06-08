class FeedQuery
  attr_reader :posts

  def initialize posts:, page:
    @posts = posts.includes(
      :goomp,
      :user,
      :likers,
      comments: [
        :user,
        :likers
      ]
    ).order(created_at: :desc).page(page).per(5)
  end
end