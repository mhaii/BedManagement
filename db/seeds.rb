# ruby encoding: utf-8

doc = Doctor.find_or_create_by(name: 'euei')

User.find_or_create_by(id: 1, username: 'mhaii', role: :administrator, password_digest: '$2a$10$OHvEWq8kHvcNf.TTu4lR1OPn4vjTQt2Te1DayI0oppip7IArdIeIi')
User.find_or_create_by(id: 2, username: 'noey',  role: :administrator, password_digest: '$2a$10$K5JGgtEuVRE2/4TNvVLkYuRRy3M7ueBmd.5KkCdR964wBQOSkSOki')
User.find_or_create_by(id: 3, username: 'boss',  role: :administrator, password_digest: '$2a$10$p5lOop4lBgiWQxo49xfo4OnS5Zq.Qi.we9tOwSdTfLLhgg/QZBVAW')

%w(cashier nurseAssistant nurse admission executive administrator).each_with_index do |role, i|
  User.find_or_create_by id: i+4, password_digest: '$2a$10$t0kFVQswS3M8aIwwzgHS5.Ewp0.Qu.DVt0mO5PrDzq8PI3TwQcf8i', username: role, role: i
end


################################################################################################

longago   = Patient.find_or_create_by(first_name: 'Longago',    last_name: 'nah', hn: 100000, sex: 0, age: 50, phone: '789')
yesterday = Patient.find_or_create_by(first_name: 'Today',      last_name: 'nah', hn: 3457,   sex: 1, age: 69, phone: '7378855')
today     = Patient.find_or_create_by(first_name: 'Today',      last_name: 'nah', hn: 28764,  sex: 1, age: 37, phone: '123547')
tomorrow  = Patient.find_or_create_by(first_name: 'Tomorrow',   last_name: 'nah', hn: 3476,   sex: 0, age: 99, phone: '0123')
longahead = Patient.find_or_create_by(first_name: 'Longahead',  last_name: 'nah', hn: 8652,   sex: 0, age: 77, phone: '043')

(0..2).each {|i|
  Admit.find_or_create_by(patient: longago,   status: i, diagnosis: 'sth', admitted_date: 1.month.ago,      edd:1.month.ago,      doctor: doc)
  Admit.find_or_create_by(patient: yesterday, status: i, diagnosis: 'sth', admitted_date: 1.day.ago,        edd:1.day.ago,        doctor: doc)
  Admit.find_or_create_by(patient: today,     status: i, diagnosis: 'sth', admitted_date: DateTime.now,     edd:DateTime.now,     doctor: doc)
  Admit.find_or_create_by(patient: tomorrow,  status: i, diagnosis: 'sth', admitted_date: 1.day.from_now,   edd:1.day.from_now,   doctor: doc)
  Admit.find_or_create_by(patient: longahead, status: i, diagnosis: 'sth', admitted_date: 1.month.from_now, edd:1.month.from_now, doctor: doc)
}

################################################################################################

m = Department.find_or_create_by(name: 'medical',     abbreviation: 'med')
o = Department.find_or_create_by(name: 'orthopedics', abbreviation: 'ortho')
s = Department.find_or_create_by(name: 'surgery',     abbreviation: 'surg')

################################################################################################

unless Ward.find_by_phone '7238-9'
  w = Ward.create(name: '84/4', remark: 'west', phone: '7238-9', departments: [o])
  (401..418).each{|i| Room.find_or_create_by(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '7236-7'
  w = Ward.create(name: '84/4', remark: 'east', phone: '7236-7', departments: [o])
  (419..436).each{|i| Room.find_or_create_by(number: i.to_s, price: 0, ward: w)}
end

unless Ward.find_by_phone '7240-1'
  w = Ward.create(name: '84/5', remark: 'west', phone: '7240-1', departments: [o, s])
  (501..508).each{|i| Room.find_or_create_by(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '8415, 8590'
  w = Ward.create(name: '84/5', remark: 'east', phone: '8415, 8590', departments: [o, s])
  (519..534).each{|i| Room.find_or_create_by(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7251, 7252'
  w = Ward.create(name: '84/6', remark: 'west', phone: '7251, 7252', departments: [o, s])
  (601..618).each{|i| Room.find_or_create_by(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7249, 7250'
  w = Ward.create(name: '84/6', remark: 'east', phone: '7249, 7250', departments: [o, s])
  (619..636).each{|i| Room.find_or_create_by(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7450, 9112'
  w = Ward.create(name: '84/7', remark: 'west', phone: '7450, 9112', departments: [o, s])
  (701..718).each{|i| Room.find_or_create_by(number: i.to_s, price: 3000, ward: w)}
end

unless Ward.find_by_phone '7255-6'
  w = Ward.create(name: '84/7', remark: 'east', phone: '7255-6', departments: [s])
  [*(719..730).map(&:to_s), '731+732', *(733..736).map(&:to_s)].each {|i|
      Room.find_or_create_by(number: i, price: 3000, ward: w) }
end

unless Ward.find_by_phone '7258'
  w = Ward.create(name: '84/8', remark: 'west', phone: '7258', departments: [s])
  (801..818).each{|i| Room.find_or_create_by(number: i.to_s, price: 1500, ward: w)}
end

unless Ward.find_by_phone '7257, 7551'
  w = Ward.create(name: '84/8', remark: 'east', phone: '7257, 7551', departments: [s])
  (819..836).each{|i| Room.find_or_create_by(number: i.to_s, price: 2000, ward: w)}
end

unless Ward.find_by_phone '7259'
  w = Ward.create(name: '84/9', remark: 'east', phone: '7259')
  (919..936).each{|i| Room.find_or_create_by(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7263'
  w = Ward.create(name: '84/10', remark: 'east', phone: '7263')
  (1001..1018).each{|i| Room.find_or_create_by(number: i.to_s, price: 2500, ward: w)}
end

unless Ward.find_by_phone '7265'
  w = Ward.create(name: '84/10', remark: 'west', phone: '7265')
  (1019..1036).each{|i| Room.find_or_create_by(number: i.to_s, price: 2500, ward: w)}
end

