class CreateIntakes < ActiveRecord::Migration
  def change
    create_table :intakes do |t|
      t.belongs_to :course
      t.datetime :start
      t.datetime :finish
      t.string :location
      t.integer :class_size

      t.timestamps null: false
    end
  end
end
