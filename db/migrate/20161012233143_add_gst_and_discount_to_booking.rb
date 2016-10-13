class AddGstAndDiscountToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :gst, :decimal
    add_column :bookings, :discount, :decimal
  end
end
