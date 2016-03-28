json.array!(@stands) do |stand|
  json.extract! stand, :id, :brand, :name, :qty, :price
  json.url stand_url(stand, format: :json)
end
