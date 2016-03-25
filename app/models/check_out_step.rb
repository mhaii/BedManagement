class CheckOutStep < ActiveRecord::Base
  enum step: %w(DOCTOR_ORDER_DC CHECK_OUT_DC CHECK_OUT_APPOINTMENT CHECK_OUT_GET_MED CHECK_OUT_RETURN_MED
                CHECK_OUT_CONTACT_FAM CHECK_OUT_BILLING CHECK_OUT_NOTIFY_FINANCE CHECK_OUT_INFORM_BILLING
                CHECK_OUT_PAYMENT CHECK_OUT_CONTACT_TRANS CHECK_OUT_PATIENT_LEAVE)
  belongs_to :admit

  validates_presence_of :admit, :step
  validates_uniqueness_of :step, scope: :admit_id

  after_save :trigger_update_event

  private
    def trigger_update_event
      WebsocketRails[:admits].trigger 'check_out', admit.check_out_steps

      # auto start last one if all previous steps are completed
      admit.check_out_steps.each do |step|
        step.update time_started: DateTime.now if step.CHECK_OUT_PATIENT_LEAVE? and !step.time_started
        break unless step.time_ended
      end

      # log to db
      self.changes.each do |attr, change|
        Log.create({user: User.current, model: self.class.name, attr: attr, change: "#{change[0]} -> #{change[1]}",
                    target_id: self.id, logged_at: DateTime.now})
      end
    end
end