class AddSubtypeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :subtype, :string
  end
end
