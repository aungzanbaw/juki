json.array!(@parts) do |part|
  json.extract! part, :id, :model, :namemm, :nameeng, :description, :machine_id, :stock, :qty, :price
  json.url part_url(part, format: :json)
end
