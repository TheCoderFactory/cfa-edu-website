class AddTermsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :accept_terms, :boolean, default: true
  end
end
