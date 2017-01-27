class AddOrderToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :order, :integer, default: 0
  end
end
