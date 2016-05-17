class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :check_in
      t.string :check_out
      t.string :total_price
      t.references :camping_car, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
