class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :wish

  validates :wish_id, uniqueness: true
end
