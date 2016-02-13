class Room < ActiveRecord::Base
  enum status: {disabled: -2, reserved: -1, available: 0, availableSoon: 1, occupied: 2}
  belongs_to  :ward
  has_one     :admit
end
