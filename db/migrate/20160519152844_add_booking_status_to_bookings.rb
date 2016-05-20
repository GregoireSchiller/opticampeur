class AddBookingStatusToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :booking_status, :string
  end
end
