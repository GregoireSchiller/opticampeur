# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'

UserReview.destroy_all
CampingCarReview.destroy_all
User.destroy_all
CampingCar.destroy_all
Booking.destroy_all

paris_street = [" rue Paul Albert", " rue Soufflot", " rue Lekain" " rue Solférino", " boulevard Haussmann", " rue de Rennes"]
lyon_street = [" avenue Jean Jaurès", " rue Garibaldi", " rue du lac", " rue Vauban", " rue du plat"]
marseille_street = [" boulevard de la libération", " rue Roger Brun", " rue de tivoli", " rue Breteuil", " rue paradis"]
lille_street = [" rue basse", " rue nationale", " rue de pas", " rue de Roubaix", " rue Faidherbe"]
bordeaux_street = [" rue Ducau", " rue Ferrere", " rue Segalier", " rue Naujac", " rue Reignier"]
rouen_street = [" rue Jeanne d'Arc", "rue des Carmes", " rue de la république", " rue rollon", " rue du gros horloge"]
nantes_street = [" rue Ogée", " rue d'enfer", " rue Fénelon", " rue du roi Albert", " rue du chateau"]
strasbourg_street = [" rue de la croix", " rue des bateliers", " rue de serruriers", " rue du saumon", " rue de la douane"]
montpellier_street = [" rue de la loge", " rue de verdun", " rue vallat", " rue joffre", " rue baudin"]
rennes_street = [" rue de Paris", " rue poullain duparc", " rue Thiers", " rue Kléber", " rue Paul Bert"]

CITIES = {Paris: paris_street,
  Lyon: lyon_street,
  Marseille: marseille_street,
  Lille: lille_street,
  Bordeaux: bordeaux_street,
  Rouen: rouen_street,
  Nantes: nantes_street,
  Strasbourg: strasbourg_street,
  Montpellier: montpellier_street,
  Rennes: rennes_street}

100.times do
  city = CITIES.keys.sample.to_s
  street = CITIES[city.to_sym].sample
  user = User.new({
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.between(80.years.ago, 18.years.ago),
    nationality: Faker::Address.country,
    address: (1..20).to_a.sample.to_s + street,
    zip_code: Faker::Address.zip_code,
    city: city,
    country: "France",
    phone_number: Faker::PhoneNumber.cell_phone
  })
  user.save
  puts "user generated"
end

puts "100 users generated"

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
    camping_car = CampingCar.new(category: category, car_model: car_model, sleep_capacity: sleep_capacity, capacity_grey_card: capacity_grey_card, price_per_day: price_per_day)
    camping_car.user = User.order("RANDOM()").first
    camping_car.save
  end
  puts "page #{i}/131 done (scrapping camping cars)"
end

500.times do
  booking = Booking.new({
    check_in: Faker::Date.between(2.years.ago, 6.months.ago),
    check_out: Faker::Date.between(6.months.ago, Date.today)
  })
  booking.user = User.order("RANDOM()").first
  booking.camping_car = CampingCar.order("RANDOM()").first
  booking.save
  user_review = UserReview.new({
    rating: (1..5).to_a.sample,
    comment: Faker::Lorem.sentence
  })
  user_review.booking = booking
  user_review.save
  camping_car_review = CampingCarReview.new({
    rating: (1..5).to_a.sample,
    comment: Faker::Lorem.sentence
  })
  camping_car_review.booking = booking
  camping_car_review.save
end
