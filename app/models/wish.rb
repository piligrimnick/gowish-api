class Wish < ApplicationRecord
  belongs_to :user

  has_one :booking, dependent: :destroy
  has_one :booker, through: :booking, source: :user

  enum state: { active: 0, realised: 1, cancelled: 2 }
end
