class Ward < ActiveRecord::Base
  has_many :users
  has_many :rooms, -> { order :number }
  has_and_belongs_to_many :departments
end
