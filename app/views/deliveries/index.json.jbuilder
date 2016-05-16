json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :msale_id, :staff_id, :customer, :nic, :address, :phone
  json.url delivery_url(delivery, format: :json)
end
