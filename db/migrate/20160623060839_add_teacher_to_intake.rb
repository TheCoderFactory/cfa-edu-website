class AddTeacherToIntake < ActiveRecord::Migration
  def change
    add_column :intakes, :teacher_name, :string
    add_column :intakes, :teacher_image, :string
  end
end
