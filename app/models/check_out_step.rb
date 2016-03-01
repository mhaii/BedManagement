class CheckOutStep < ActiveRecord::Base
  belongs_to :admit
  before_create { self.time_started = DateTime.now }
end