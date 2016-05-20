class CampingCar < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  CATEGORIES = ["Camping-car Profilé", "Campin-car Capucine", "Camping-car Intégral", "Fourgon aménagé", "Van", "Autre"]
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :camping_car_reviews, through: :bookings
  validates :capacity_grey_card, :category, :car_model, :sleep_capacity, :price_per_day, presence: true
  # validates :plate, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES, allow_nil: false }
end
