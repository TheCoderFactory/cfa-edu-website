class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :url
      t.string :name
      t.string :image
      t.integer :order
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
