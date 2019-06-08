json.extract! @link, :title, :url, :image, :description, :video
json.card render(
  partial: "posts/post_card",
  locals: { post: @post },
  formats: [:html]
)