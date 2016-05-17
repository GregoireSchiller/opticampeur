# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'

CampingCar.destroy_all

for i in 1..131 do
  url = "https://www.jelouemoncampingcar.com/louer-un-camping-car-entre-particuliers/?page=#{i}"
  html_file = open(url)
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.card.card_odd').each do |element|
    category = element.search('.card_content h4').children.text
    car_model = element.search('.card_content .card_content_subTitle').text
    sleep_capacity = element.search('.card_content .card_content_footer.clearfix .places span').last.children.text
    capacity_grey_card = element.search('.card_content .card_content_footer.clearfix .places span').first.children.text
    price_per_day = element.search('.card_top .card_top_price').children.children.text.gsub(/\D/,'')
    CampingCar.create(category: category, car_model: car_model, sleep_capacity: sleep_capacity, capacity_grey_card: capacity_grey_card, price_per_day: price_per_day)
  end
end
