class SchoolsController < ApplicationController
  def index
    @coding_curriculum_courses = Course.where(subtype: "Coding Curriculum")
    @maker_space_courses = Course.where(subtype: "Maker Space")
    @teacher_training_courses = Course.where(subtype: "Maker Space")
  end
end
