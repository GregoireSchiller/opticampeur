class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :search

  def home
    @camping_cars = CampingCar.all
    @selected_camping_cars = []
    15.times do |a|
      a = @camping_cars.sample
      @selected_camping_cars << a
    end
  end

  def search
    @search_term = params[:search_term]
    @camping_cars = CampingCar.all
    @camping_cars_available = []
    @camping_cars.each do |camping_car|
      if camping_car.user.city == @search_term
        @camping_cars_available << camping_car
      end
    end
    @markers = Gmaps4rails.build_markers(@camping_cars_available) do |camping_car, marker|
      marker.lat camping_car.user.latitude
      marker.lng camping_car.user.longitude
    end

  end

  def usershow
  end
end
