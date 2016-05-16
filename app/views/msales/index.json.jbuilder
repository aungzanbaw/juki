json.array!(@msales) do |msale|
  json.extract! msale, :id, :proforma, :customer, :nic, :address, :phone, :total, :debt, :tax
  json.url msale_url(msale, format: :json)
end
