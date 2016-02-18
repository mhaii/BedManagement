json.array! @wards  do |ward|
  json.merge! ward.as_json
  json.rooms  ward.rooms.as_json
end
