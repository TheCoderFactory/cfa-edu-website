class AddInstructorLinkedIn < ActiveRecord::Migration
  def change
    add_column :intakes, :teacher_linkedin, :string
  end
end
