class CreateFastTrackPayments < ActiveRecord::Migration
  def change
    create_table :fast_track_payments do |t|
      t.decimal :amount
      t.boolean :paid, default: false
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :pay_type
      t.string :student_id

      t.timestamps null: false
    end
  end
end
