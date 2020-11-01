class Wish < ApplicationRecord
  belongs_to :user

  enum state: { active: 0, realised: 1, cancelled: 2 }
end
