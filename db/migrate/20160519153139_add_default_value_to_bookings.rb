class AddDefaultValueToBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :booking_status, :string, default: "En attente de confirmation"
  end
end
