class User < ActiveRecord::Base
  enum role: [:cashier, :nurseAssistance, :nurse, :admission, :administrator]
  validates_uniqueness_of :username

  has_secure_password
end
