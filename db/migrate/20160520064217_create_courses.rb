class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_type
      t.string :name
      t.text :description
      t.text :tagline
      t.string :slug
      t.decimal :price

      t.timestamps null: false
    end
  end
end
