class Log < ActiveRecord::Base
  # Prevent modification of existing records
  def readonly?
    !new_record?
  end

  has_one :user

  validates_presence_of :user, :model, :changes, :timestamps

  # Prevent objects from being destroyed
  before_destroy { raise ActiveRecord::ReadOnlyRecord }
end
