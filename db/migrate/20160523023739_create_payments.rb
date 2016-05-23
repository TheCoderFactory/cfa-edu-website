class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :booking
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
