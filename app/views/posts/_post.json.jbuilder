json.extract! post, :id, :body, :comments_count, :goomp_id, :user_id, :subtopic_id, :created_at, :updated_at
json.url post_url(post, format: :json)