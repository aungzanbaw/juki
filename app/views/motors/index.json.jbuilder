json.array!(@motors) do |motor|
  json.extract! motor, :id, :brand, :name, :watt, :qty, :price
  json.url motor_url(motor, format: :json)
end
