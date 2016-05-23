class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :intake
      t.belongs_to :promo_code
      t.integer :people_attending
      t.decimal :total_cost

      t.timestamps null: false
    end
  end
end
