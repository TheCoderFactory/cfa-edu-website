class AddTeacherTitleToIntake < ActiveRecord::Migration
  def change
    add_column :intakes, :teacher_title, :string
  end
end
