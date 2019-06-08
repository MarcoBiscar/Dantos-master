json.extract! follow, :id, :user_id, :followable_id, :followable_type, :created_at, :updated_at
json.url follow_url(follow, format: :json)