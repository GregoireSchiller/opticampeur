class CampingCar < ActiveRecord::Base
  CATEGORIES = ["Low profile", "Coachbuilt", "A class", "Campervan", "Converted van", "Other"]
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :camping_car_reviews, through: :bookings
  # validates :capacity_grey_card, :plate, :brand, :category, :car_model, :sleep_capacity, :fuel, :consumption, :km, :gear_type, :entry_into_circulation, :original_value, :registration_country, :price_per_day, presence: true
  validates :plate, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES, allow_nil: false }
end
