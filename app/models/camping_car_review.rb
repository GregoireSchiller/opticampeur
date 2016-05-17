class CampingCarReview < ActiveRecord::Base
  belongs_to :booking
  validates :rating, :comment, presence: true
end
