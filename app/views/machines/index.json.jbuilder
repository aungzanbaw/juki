json.array!(@machines) do |machine|
  json.extract! machine, :id, :model, :series, :namemm, :nameeng, :description, :company, :stock, :qty
  json.url machine_url(machine, format: :json)
end
