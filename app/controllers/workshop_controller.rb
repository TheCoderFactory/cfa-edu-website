class WorkshopController < ApplicationController
  def index
    @coding_for_beginners = Course.find_by(name: "Coding For Beginners")
    @twelve_week_course = Course.find_by(name: "12 Week Course")
    @coding_kickstarter = Course.find_by(name: "Coding Kickstarter")
    @courses = Course.where(course_type: "Workshop")
    @intakes = Intake.all.future_intakes.chron_order.first(4)
  end
end
