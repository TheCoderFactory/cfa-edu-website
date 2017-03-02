class WorkshopController < ApplicationController
  def index
    @course1 = Course.find_by(name: "Coding For Beginners")
    @course2 = Course.find_by(name: "Web App Builder")
    @course3 = Course.find_by(name: "Coding Kickstarter")
    @courses = Course.active_courses.where(course_type: "Workshop").order(order: :asc)
    @intakes = Intake.all.future_intakes.active_intakes.chron_order.first(4)
  end
end
