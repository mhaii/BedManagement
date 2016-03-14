class CheckOutStep < ActiveRecord::Base
  enum step: %w(DOCTOR_ORDER_DC CHECK_OUT_DC CHECK_OUT_APPOINTMENT CHECK_OUT_GET_MED CHECK_OUT_RETURN_MED
                CHECK_OUT_CONTACT_FAM CHECK_OUT_BILLING CHECK_OUT_NOTIFY_FINANCE CHECK_OUT_INFORM_BILLING
                CHECK_OUT_PAYMENT CHECK_OUT_CONTACT_TRANS CHECK_OUT_PATIENT_LEAVE)
  belongs_to :admit
  validates :admit, presence: true
  validates :step, presence: true, uniqueness: {scope: :admit_id}
  after_save :trigger_update_event

  private
    def trigger_update_event
      WebsocketRails[:admits].trigger 'check_out', admit.check_out_steps
    end
end