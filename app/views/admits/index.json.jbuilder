json.array!(@admits) do |admit|
  json.extract! admit, :id
  json.url admit_url(admit, format: :json)
end
