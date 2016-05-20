class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to user_path(@booking.user)
    else
      @camping_car = @booking.camping_car
      render 'camping_cars/show'
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.booking_status = params[:booking].first[1]
    if @booking.save
      respond_to do |format|
        format.html { redirect_to user_path(@booking.user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'users/show' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path(@booking.user)
  end

  private

  def booking_params
    params.require(:booking).permit(:id, :check_in, :check_out, :camping_car_id, :booking_status)
  end
end
