class Customer < ApplicationRecord
  has_many :bookings

  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :email, uniqueness: true
end
