class AddPerToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :per, :string
  end
end
