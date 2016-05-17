class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings, dependent: :destroy
  has_many :user_reviews, through: :bookings
  has_many :camping_cars, dependent: :destroy
end
