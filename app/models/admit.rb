class Admit < ActiveRecord::Base
  before_save :update_room

  enum status: [:pending, :confirmed, :currentlyAdmit, :preDischarged, :discharged]
  belongs_to  :patient
  belongs_to  :room
  belongs_to  :doctor

  private
    def update_room
      case self.status
        when 'preDischarged'
          self.room.update status: :availableSoon
        when 'discharged'
          self.room = nil
      end if status_changed?

      if room_id_changed?
        Room.find_by_id(self.room_id_was).update status: :available unless self.room_id_was.nil?
        Room.find_by_id(self.room_id).update status: :occupied      unless self.room_id.nil?
      end
    end
end
