class Booking < ActiveRecord::Base
  belongs_to :camping_car
  belongs_to :user
  has_one :user_review, dependent: :destroy
  has_one :camping_car_review, dependent: :destroy
  validates :check_in, :check_out, presence: true
end
