ward ||= @ward
json.merge! ward.as_json
json.rooms  ward.rooms do |room|
  json.merge! room.as_json
  if room.admit
    json.admit    room.admit
    json.doctor   room.admit.doctor
    json.patient  room.admit.patient
  end
end
