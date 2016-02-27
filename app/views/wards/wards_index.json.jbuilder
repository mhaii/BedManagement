#json.partial! 'wards/ward_index', collection: @wards, as: :ward

json.array! @wards do |ward|
  json.partial! 'wards/ward_index', ward: ward
end
