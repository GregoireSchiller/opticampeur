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
    # if !params[:capacity].blank? && !params[:price].blank? && category_checked? && !params[:city].blank?
    #   @camping_cars_available = CampingCar.joins(:user).where(user: {city: params[:city]}).where(price_per_day: (0..params[:price].to_i).to_a, category: categories_checked, capacity_grey_card: params[:capacity])
    # elsif !params[:capacity].blank? && !params[:price].blank? && category_checked? && params[:city].blank?
    #   @camping_cars_available =CampingCar.where(capacity_grey_card: params[:capacity], price_per_day: params[:price], category: categories_checked)
    # elsif !params[:capacity].blank? && !params[:price].blank? && !params[:city].blank? && !category_checked?
    #   @camping_cars_available =CampingCar.joins(:user).where(user: {city: params[:city]}).where(capacity_grey_card: params[:capacity], price_per_day: params[:price])
    # elsif !params[:capacity].blank? && !params[:price].blank? && !category_checked? && params[:city].blank?
    #   @camping_cars_available =CampingCar.where(capacity_grey_card: params[:capacity], price_per_day: params[:price])
    # elsif !params[:capacity].blank? && category_checked? && !params[:city].blank? && params[:price].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:capacity].blank? && category_checked? && params[:city].blank? && params[:price].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:capacity].blank? && !params[:city].blank? && params[:price].blank? && !category_checked?
    #   @camping_cars_available =CampingCar
    # elsif !params[:capacity].blank? && params[:price].blank? && category_checked? && params[:city].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:price].blank? && category_checked? && !params[:city].blank? && params[:capacity].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:price].blank? && category_checked? && params[:capacity].blank? && params[:city].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:price].blank? && !params[:city].blank? && params[:capacity].blank? && !category_checked?
    #   @camping_cars_available =CampingCar
    # elsif !params[:price].blank? && params[:capacity].blank? && category_checked? && params[:city].blank?
    #   @camping_cars_available =CampingCar
    # elsif category_checked? && !params[:city].blank? && params[:capacity].blank? && params[:price].blank?
    #   @camping_cars_available =CampingCar
    # elsif category_checked? params[:capacity].blank? && params[:price].blank? && params[:city].blank?
    #   @camping_cars_available =CampingCar
    # elsif !params[:city].blank? && params[:capacity].blank? && params[:price].blank? && !category_checked?
    #   @camping_cars_available =CampingCar
    # else params[:capacity].blank? && params[:price].blank? && category_checked? && params[:city].blank?
    #   @camping_cars_available =CampingCar.
    # end


    if !params[:capacity].blank? && !params[:price].blank? && category_checked?
      @camping_cars_available = CampingCar.joins(:user).where(price_per_day: (0..params[:price].to_i).to_a, category: categories_checked, capacity_grey_card: params[:capacity])
    elsif !params[:capacity].blank? && !params[:price].blank? && category_checked?
      @camping_cars_available = CampingCar.joins(:user).where(price_per_day: (0..params[:price].to_i).to_a, capacity_grey_card: params[:capacity])
    elsif !params[:capacity].blank? && category_checked?
      @camping_cars_available = CampingCar.joins(:user).where(category: categories_checked, capacity_grey_card: params[:capacity])
    elsif !params[:price].blank? && category_checked?
      @camping_cars_available = CampingCar.joins(:user).where(category: categories_checked, price_per_day: (0..params[:price].to_i).to_a)
    elsif !params[:price].blank?
      @camping_cars_available = CampingCar.joins(:user).where(price_per_day: (0..params[:price].to_i).to_a)
    elsif category_checked?
      @camping_cars_available = CampingCar.joins(:user).where(category: categories_checked)
    elsif !params[:capacity].blank?
      @camping_cars_available = CampingCar.joins(:user).where(capacity_grey_card: params[:capacity])
    else
      @camping_cars_available = CampingCar.joins(:user).all
    end
    if params[:city]
      @camping_cars_available = @camping_cars_available.where("users.city iLIKE ?", params[:city])
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
    if params[:category_profile] || params[:category_capucine] || params[:category_integral] || params[:category_fourgon] || params[:category_van] || params[:category_autre]
      return true
    else
      return false
    end
  end

  def categories_checked
    [params[:category_profile] ? CampingCar::CATEGORIES[0] : nil, params[:category_capucine] ? CampingCar::CATEGORIES[1] : nil, params[:category_integral] ? CampingCar::CATEGORIES[2] : nil, params[:category_fourgon] ? CampingCar::CATEGORIES[3] : nil, params[:category_van] ? CampingCar::CATEGORIES[4] : nil, params[:category_autre] ? CampingCar::CATEGORIES[5] : nil].reject { |cat| cat.blank? }
  end

end
