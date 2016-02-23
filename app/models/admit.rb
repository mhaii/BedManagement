class Admit < ActiveRecord::Base
  enum status: {inICU: -1, pending: 0, confirmed: 1, currentlyAdmit: 2, preDischarged: 3, discharged: 4}
  belongs_to  :patient
  belongs_to  :room
  belongs_to  :doctor

  before_save :check_status
  before_save :check_room
  # use non-callback method to avoid infinite loop
  # http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#skipping-callbacks

  private
    def check_status
      case status
        when 'preDischarged'
          room.availableSoon! unless room.availableSoon? # :availableSoon
        when 'discharged'
          self.room = nil
      end if status_changed?
    end

    def check_room
      if room_id_changed?
        Room.find(self.room_id_was).available!  unless room_id_was.nil?
        room.update_column :status, 2 unless room_id.nil? or room.occupied? # :occupied
      end
    end
end
