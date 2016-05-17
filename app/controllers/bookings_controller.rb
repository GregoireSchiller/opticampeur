class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to camping_cars_path
    else
      @camping_car = @booking.camping_car
      render 'camping_cars/show'
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path(@booking.user)
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :camping_car_id)
  end
end
