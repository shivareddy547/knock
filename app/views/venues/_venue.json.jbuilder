json.extract! venue, :id, :name, :description, :image, :created_at, :updated_at
json.url venue_url(venue, format: :json)
