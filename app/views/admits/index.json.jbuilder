json.array! @admits do |admit|
  json.merge!         admit.as_json
  json.admitted_date  admit.admitted_date.to_f * 1000
end