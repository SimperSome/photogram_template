json.extract! photo, :id, :caption, :image, :owner_id, :location, :created_at, :updated_at
json.url photo_url(photo, format: :json)
