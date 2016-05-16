json.array!(@sales) do |sale|
  json.extract! sale, :id, :proforma, :staff_id, :customer, :address, :nic, :phone, :cash, :total, :postpone, :tax
  json.url sale_url(sale, format: :json)
end
