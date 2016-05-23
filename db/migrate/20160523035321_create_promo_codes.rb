class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :code
      t.integer :percent
      t.string :note

      t.timestamps null: false
    end
  end
end
