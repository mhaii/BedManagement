json.array! @admits do |admit|
  json.merge!   admit.as_json
  json.patient  admit.patient

  if admit.room
    json.room do
      json.merge! admit.room
      #json.ward   admit.room.ward
    end
  end
end