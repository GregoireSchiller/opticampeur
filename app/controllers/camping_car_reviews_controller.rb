class CampingCarReviewsController < ApplicationController

  def new
    set_booking
    @camping_car_review = CampingCarReview.new
  end

  def create
    @camping_car_review = CampingCarReview.new(camping_car_review_params)
    if @camping_car_review.save
      redirect_to user_path(@camping_car_review.booking.user)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def camping_car_review_params
    params.require(:camping_car_review).permit(:rating, :comment, :booking_id)
  end
end
