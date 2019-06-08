json.files [@photo] do |photo|
  json.url photo.data.url
  json.cover_url photo.data.url(:cover)
  json.delete_url photo_path(photo, format: :json)
end

# {"files": [
#   {
#     "name": "picture1.jpg",
#     "size": 902604,
#     "url": "http:\/\/example.org\/files\/picture1.jpg",
#     "thumbnailUrl": "http:\/\/example.org\/files\/thumbnail\/picture1.jpg",
#     "deleteUrl": "http:\/\/example.org\/files\/picture1.jpg",
#     "deleteType": "DELETE"
#   },
#   {
#     "name": "picture2.jpg",
#     "size": 841946,
#     "url": "http:\/\/example.org\/files\/picture2.jpg",
#     "thumbnailUrl": "http:\/\/example.org\/files\/thumbnail\/picture2.jpg",
#     "deleteUrl": "http:\/\/example.org\/files\/picture2.jpg",
#     "deleteType": "DELETE"
#   }
# ]}