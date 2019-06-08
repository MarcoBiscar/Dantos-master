json.extract! review, :id, :goomp_id, :user_id, :rating, :body, :created_at, :updated_at
json.url review_url(review, format: :json)