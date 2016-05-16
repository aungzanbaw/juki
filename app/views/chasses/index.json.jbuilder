json.array!(@chasses) do |chass|
  json.extract! chass, :id, :msale_id, :msale_detail_id, :chassisnum
  json.url chass_url(chass, format: :json)
end
