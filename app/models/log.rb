class Log < ActiveRecord::Base
  # Prevent modification of existing records
  def readonly?
    !new_record?
  end

  belongs_to :user

  validates_presence_of :user, :model
end
