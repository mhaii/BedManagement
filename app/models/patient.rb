class Patient < ActiveRecord::Base
  self.primary_key = :hn
  enum sex: [:male, :female]
  has_many  :admits, dependent: :destroy
end
