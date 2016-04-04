json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :name, :address, :nic, :phone, :total
  json.url purchase_url(purchase, format: :json)
end
