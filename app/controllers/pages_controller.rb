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
    # raise
    if !params[:capacity].blank? && !params[:price].blank? && category_checked?
      @camping_cars_available = CampingCar.where(price_per_day: (0..params[:price].to_i).to_a, category: categories_checked, capacity_grey_card: params[:capacity])
    elsif !params[:capacity].blank? && !params[:price].blank?
      @camping_cars_available = CampingCar.where(price_per_day: (0..params[:price].to_i).to_a, capacity_grey_card: params[:capacity])
    elsif !params[:capacity].blank? && category_checked?
      @camping_cars_available = CampingCar.where(category: categories_checked, capacity_grey_card: params[:capacity])
    elsif !params[:price].blank? && category_checked?
      @camping_cars_available = CampingCar.where(category: categories_checked, price_per_day: (0..params[:price].to_i).to_a)
    elsif !params[:price].blank?
      @camping_cars_available = CampingCar.where(price_per_day: (0..params[:price].to_i).to_a)
    elsif category_checked?
      @camping_cars_available = CampingCar.where(category: categories_checked)
    elsif !params[:capacity].blank?
      @camping_cars_available = CampingCar.where(capacity_grey_card: params[:capacity])
    else
      @camping_cars_available = CampingCar.all
    end
    if @camping_cars_available.empty?
      @camping_cars_available = CampingCar.all
      flash[:alert] = "Pas de résultat à votre recherche"
    end
    @markers = Gmaps4rails.build_markers(@camping_cars_available) do |camping_car, marker|
      marker.lat camping_car.user.latitude
      marker.lng camping_car.user.longitude
    end
  end

  def usershow
  end

  private

  def category_checked?
    if params[:category_profile] != 0 || params[:category_capucine] != 0 || params[:category_integral] != 0 || params[:category_fourgon] != 0 || params[:category_van] != 0 || params[:category_autre] != 0
      return true
    else
      return false
    end
  end

  def categories_checked
    [params[:category_profile] ? CampingCar::CATEGORIES[0] : nil, params[:category_capucine] ? CampingCar::CATEGORIES[1] : nil, params[:category_integral] ? CampingCar::CATEGORIES[2] : nil, params[:category_fourgon] ? CampingCar::CATEGORIES[3] : nil, params[:category_van] ? CampingCar::CATEGORIES[4] : nil, params[:category_autre] ? CampingCar::CATEGORIES[5] : nil].reject { |cat| cat.blank? }
  end

end
