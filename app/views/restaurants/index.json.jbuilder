json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :description, :url, :score
  json.url restaurant_url(restaurant, format: :json)
end
