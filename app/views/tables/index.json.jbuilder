json.array!(@tables) do |table|
  json.extract! table, :id, :brand, :name, :width, :height, :qty, :price
  json.url table_url(table, format: :json)
end
