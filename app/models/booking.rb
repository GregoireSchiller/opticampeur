class Booking < ActiveRecord::Base
  STATUS = ["En attente de confirmation", "Confirmée", "Refusée", "Passée"]
  belongs_to :camping_car
  belongs_to :user
  has_one :user_review, dependent: :destroy
  has_one :camping_car_review, dependent: :destroy
  validates :check_in, :check_out, presence: true
  validates :camping_car, presence: true
  validates :booking_status, inclusion: { in: STATUS, allow_nil: false }
end
