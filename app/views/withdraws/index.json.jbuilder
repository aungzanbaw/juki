json.array!(@withdraws) do |withdraw|
  json.extract! withdraw, :id, :msale_id, :staff_id
  json.url withdraw_url(withdraw, format: :json)
end
