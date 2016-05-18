class CampingCarsController < ApplicationController
  before_action :set_camping_car, only: [:show, :edit, :update, :destroy]

  def index
    @camping_cars = CampingCar.order(created_at: :desc)
  end

  def show
    @booking = Booking.new
  end

  def new
    @camping_car = CampingCar.new
  end

  def create
    @camping_car = CampingCar.new(camping_car_params)
    @camping_car.user = current_user
    if @camping_car.save
      redirect_to camping_car_path(@camping_car)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @camping_car.update(camping_car_params)
    redirect_to camping_car_path(@camping_car)
  end

  def destroy
    @camping_car.destroy
    redirect_to camping_cars_path
  end

  private

  def camping_car_params
    params.require(:camping_car).permit(:capacity_grey_card, :plate, :brand, :category, :car_model, :sleep_capacity, :fuel, :consumption, :km, :gear_type, :entry_into_circulation, :original_value, :registration_country, :price_per_day)
  end

  def set_camping_car
    @camping_car = CampingCar.find(params[:id])
  end
end
