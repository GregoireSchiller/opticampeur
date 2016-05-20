class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :bookings, dependent: :destroy
  has_many :user_reviews, through: :bookings
  has_many :camping_cars, dependent: :destroy
  has_many :own_bookings, class_name: "Booking", through: :camping_cars, source: :bookings

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  def self.find_for_facebook_oauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]  # Fake password for validation
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.picture = auth.info.image
        user.token = auth.credentials.token
        user.token_expiry = Time.at(auth.credentials.expires_at)
      end
    end


  def full_address
    [address, city, country].compact.join(', ')
  end
end
