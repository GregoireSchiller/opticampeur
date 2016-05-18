class UsersController < ApplicationController

  def show
    @user_camping_car_bookings = []
    @user = User.find(params[:id])
    @user_bookings = @user.bookings
    @user_camping_car = @user.camping_cars
    @user_camping_car.each do |camping_car|
      @user_camping_car_bookings << camping_car.bookings
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :nationality, :address, :zip_code, :city, :country, :phone_number)
  end

end
