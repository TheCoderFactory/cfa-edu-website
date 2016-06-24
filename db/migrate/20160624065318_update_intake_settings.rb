class UpdateIntakeSettings < ActiveRecord::Migration
  def change
    remove_column :intakes, :class_size
    add_column :intakes, :days, :string
  end
end
