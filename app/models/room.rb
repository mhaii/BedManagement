class Room < ActiveRecord::Base
  enum status: {disabled: -2, reserved: -1, available: 0, availableSoon: 1, occupied: 2}
  belongs_to  :ward
  has_one     :admit

  validates_presence_of :number, :ward

  before_save :check_status

  def check_status
    if [status_was, status].include? 'disabled'
      WebsocketRails[:admits].trigger 'updated', self
    end
  end
end
