json.array! @admits do |admit|
  json.merge!         admit.as_json
  json.patient        admit.patient
  json.doctor         admit.doctor if admit.doctor

  json.check_out_steps  admit.check_out_steps if admit.check_out_steps

  if admit.room
    json.room do
      json.merge! admit.room.as_json
      json.ward   admit.room.ward
    end
  end
end