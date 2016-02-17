json.array! @wards do |ward|
  json.merge!  ward.as_json
  json.count   ward.rooms.where(status: 'available').count
end