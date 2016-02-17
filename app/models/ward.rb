class Ward < ActiveRecord::Base
  has_many :rooms
  has_and_belongs_to_many :departments
end