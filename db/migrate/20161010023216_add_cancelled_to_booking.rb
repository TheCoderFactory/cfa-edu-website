class AddCancelledToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :cancelled, :boolean, default: false
  end
end
