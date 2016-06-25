class AddStatusToIntake < ActiveRecord::Migration
  def change
    add_column :intakes, :status, :string, default: "Active"
  end
end
