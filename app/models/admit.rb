class Admit < ActiveRecord::Base
  enum status: [:pending, :confirmed, :currentlyAdmit, :preDischarged, :discharged]
  belongs_to  :patient
  belongs_to  :room
  belongs_to  :doctor
end
