class Court < ApplicationRecord
  has_many :bookings

  validates :name, presence: true
  validates :code, presence: true
  validates :kind, presence: true
  validates :code, uniqueness: true
end
