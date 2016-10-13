class AddDiscountCodeToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :discount_code, :string
  end
end
