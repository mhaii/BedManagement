json.array! @wards  do |ward|
  json.merge! ward.as_json
  json.rooms  @ward.rooms do |room|
    json.merge! room.as_json
    if room.admit
      json.admit room.admit
      json.patient room.admit.patient
    end
  end
end
