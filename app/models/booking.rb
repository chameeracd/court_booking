class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :court
end
