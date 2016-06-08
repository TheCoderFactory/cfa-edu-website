class UpdateBookingAttributes < ActiveRecord::Migration
  def change
    add_column :bookings, :firstname, :string
    add_column :bookings, :lastname, :string
    add_column :bookings, :email, :string
    add_column :bookings, :phone, :string
    add_column :bookings, :age, :string
    add_column :bookings, :city, :string
    add_column :bookings, :country, :string
  end
end
