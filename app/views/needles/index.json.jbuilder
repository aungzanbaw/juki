json.array!(@needles) do |needle|
  json.extract! needle, :id, :model, :category, :size, :machine_id, :stock, :qty, :price
  json.url needle_url(needle, format: :json)
end
