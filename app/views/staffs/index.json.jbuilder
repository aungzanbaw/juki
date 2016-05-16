json.array!(@staffs) do |staff|
  json.extract! staff, :id, :name, :phone, :address, :password_digest
  json.url staff_url(staff, format: :json)
end
