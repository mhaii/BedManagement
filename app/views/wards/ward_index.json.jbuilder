json.merge! @ward.as_json
json.rooms  @ward.rooms do |room|
  json.merge! room.as_json
  if room.admit
    json.admit do
      json.merge!           room.admit.as_json
      json.doctor           room.admit.doctor
      json.patient          room.admit.patient
      json.check_out_steps  room.admit.check_out_steps
    end
  end
end
