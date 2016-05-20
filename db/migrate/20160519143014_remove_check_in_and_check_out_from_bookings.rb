class RemoveCheckInAndCheckOutFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :check_in, :string
    remove_column :bookings, :check_out, :string
  end
end
