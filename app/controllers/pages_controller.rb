class PagesController < ApplicationController

  def home
    @camping_cars = CampingCar.all
    @selected_camping_cars = []
    15.times do |a|
      a = @camping_cars.sample
      @selected_camping_cars << a
    end
    return @selected_camping_cars
  end

  def usershow
  end
end
