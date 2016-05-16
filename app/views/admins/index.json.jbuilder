json.array!(@admins) do |admin|
  json.extract! admin, :id, :name, :nic, :phone, :email, :address, :password_digest
  json.url admin_url(admin, format: :json)
end
