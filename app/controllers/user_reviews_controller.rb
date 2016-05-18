class UserReviewsController < ApplicationController

  def new
    set_booking
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(user_review_params)
    if @user_review.save
      redirect_to user_path(@user_review.booking.user)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def user_review_params
    params.require(:user_review).permit(:rating, :comment, :booking_id)
  end
end
