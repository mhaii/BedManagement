class CheckOutStep < ActiveRecord::Base
  belongs_to :admit
  before_create { self.time_started = DateTime.now }
  after_save :trigger_update_event

  private
    def trigger_update_event
      WebsocketRails[:admits].trigger 'check_out', self
    end
end