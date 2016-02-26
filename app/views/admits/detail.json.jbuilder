json.array! @admits do |admit|
  json.merge!   admit.as_json
  json.patient  admit.patient

  json.doctor   admit.doctor if admit.doctor

  if admit.room
    json.wards  admit.room.ward if admit.room.ward
    json.room do
      json.merge! admit.room
    end
  end
end