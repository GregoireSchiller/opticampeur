class CreateCampingCars < ActiveRecord::Migration
  def change
    create_table :camping_cars do |t|
      t.string :capacity_grey_card
      t.string :brand
      t.string :category
      t.string :car_model
      t.string :sleep_capacity
      t.string :fuel
      t.string :consumption
      t.string :km
      t.string :gear_type
      t.string :entry_into_circulation
      t.string :original_value
      t.string :registration_country
      t.string :price_per_day
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
