json.array!(@debts) do |debt|
  json.extract! debt, :id, :msale_id, :amount, :date, :paid
  json.url debt_url(debt, format: :json)
end
