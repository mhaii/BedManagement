# ruby encoding: utf-8

m = Department.find_by_name 'medical'
o = Department.find_by_name 'orthopedics'
s = Department.find_by_name 'surgery'

unless m
  m = Department.create(name: 'medical', abbreviation: 'med')
end
unless o
  o = Department.create(name: 'orthopedics', abbreviation: 'ortho')
end
unless s
  s = Department.create(name: 'surgery', abbreviation: 'surg')
end

unless Ward.find_by_phone '7238-9'
  w = Ward.create(name: '84/4', remark: 'west', phone: '7238-9', departments: [o])
  (401..418).each{|i| Room.create(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '7236-7'
  w = Ward.create(name: '84/4', remark: 'east', phone: '7236-7', departments: [o])
  (419..436).each{|i| Room.create(number: i.to_s, price: 0, ward: w)}
end

unless Ward.find_by_phone '7240-1'
  w = Ward.create(name: '84/5', remark: 'west', phone: '7240-1', departments: [o, s])
  (501..508).each{|i| Room.create(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '8415, 8590'
  w = Ward.create(name: '84/5', remark: 'east', phone: '8415, 8590', departments: [o, s])
  (519..534).each{|i| Room.create(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7251, 7252'
  w = Ward.create(name: '84/6', remark: 'west', phone: '7251, 7252', departments: [o, s])
  (601..618).each{|i| Room.create(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7249, 7250'
  w = Ward.create(name: '84/6', remark: 'east', phone: '7249, 7250', departments: [o, s])
  (619..636).each{|i| Room.create(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7450, 9112'
  w = Ward.create(name: '84/7', remark: 'west', phone: '7450, 9112', departments: [o, s])
  (701..718).each{|i| Room.create(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7255-6'
  w = Ward.create(name: '84/7', remark: 'east', phone: '7255-6', departments: [s])
  [*(719..730).map(&:to_s), '731+732', *(733..736).map(&:to_s)].each {|i|
      Room.create(number: i, price: 3000, ward: w) }
end

unless Ward.find_by_phone '7258'
  w = Ward.create(name: '84/8', remark: 'west', phone: '7258', departments: [s])
  (801..818).each{|i| Room.create(number: i.to_s, price: 1500, ward: w)}
end

unless Ward.find_by_phone '7257, 7551'
  w = Ward.create(name: '84/8', remark: 'east', phone: '7257, 7551', departments: [s])
  (819..836).each{|i| Room.create(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '7259'
  w = Ward.create(name: '84/9', remark: 'east', phone: '7259')
  (919..936).each{|i| Room.create(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7263'
  w = Ward.create(name: '84/10', remark: 'east', phone: '7263')
  (1001..1018).each{|i| Room.create(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7265'
  w = Ward.create(name: '84/10', remark: 'west', phone: '7265')
  (1019..1036).each{|i| Room.create(number: i.to_s, price: 2500, ward: w)}
end

