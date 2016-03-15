class Admit < ActiveRecord::Base
  enum status: {inICU: -1, pending: 0, confirmed: 1, currentlyAdmit: 2, preDischarged: 3, discharged: 4}
  belongs_to  :patient
  belongs_to  :room
  belongs_to  :doctor
  has_many    :check_out_steps, dependent: :destroy

  validates_presence_of :patient

  before_save   :check_status
  before_save   :check_room
  after_save    :trigger_update_event
  after_destroy :trigger_destroy_event

  # use non-callback method to avoid infinite loop
  # http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#skipping-callbacks

  private
    def trigger_update_event
      WebsocketRails[:admits].trigger 'updated', self
    end

    def trigger_destroy_event
      WebsocketRails[:admits].trigger 'destroyed'
    end

    def check_status
      if status_changed?
        if [status_was, status].include? 'inICU'
          WebsocketRails[:admits].trigger 'icu'
        end
        if [status_was, status].include? 'preDischarged'
          WebsocketRails[:admits].trigger 'check_out'
        end

        case status
          when 'preDischarged'
            room.availableSoon! unless self.room.nil? or room.availableSoon?
            if self.id  # if not forced created
              sql = ["(#{self.id}, 0, '#{DateTime.now.utc.strftime '%F %T'}', null)"]
              (1..11).each {|i| sql.push "(#{self.id}, #{i}, null, null)" }
              ActiveRecord::Base.connection.execute "INSERT INTO check_out_steps (`admit_id`, `step`, `time_started`, `time_ended`) VALUES #{sql.join(', ')}"
            end
          when 'discharged'
            self.room = nil
        end
      end
    end

    def check_room
      if room_id_changed?
        Room.find(self.room_id_was).available!  unless room_id_was.nil?
        room.update_column :status, 2 unless room_id.nil? or room.occupied?
      elsif status_was == 'inICU'
        room.update_column :status, 2 unless room_id.nil? or room.occupied?
      end
    end
end
