class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings, dependent: :destroy
  has_many :user_reviews, through: :bookings
  has_many :camping_cars, dependent: :destroy
  has_many :own_bookings, class_name: "Booking", through: :camping_cars, source: :bookings

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  def full_address
    [address, city, country].compact.join(', ')
  end
end
