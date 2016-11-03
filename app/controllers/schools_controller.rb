class SchoolsController < ApplicationController
  def index
    @coding_and_the_digital_curriculum = Course.find_by(name: "Coding and the Digital Curriculum")
    @student_deeper_dive = Course.find_by(name: "Student Deeper Dive")
    @hands_on_coding = Course.find_by(name: "Hands On Coding")
    @courses = Course.where(course_type: "Schools")
  end
end
