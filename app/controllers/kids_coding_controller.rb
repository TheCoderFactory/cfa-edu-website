class KidsCodingController < ApplicationController
  def index
    @weekend_courses = Course.where(course_type: "Kids").where("subtype like ?", "%Weekend%")
    @weekend_7_12_courses = @weekend_courses.where(subtype: "Weekend 7-12")
    @weekend_12_plus_courses = @weekend_courses.where(subtype: "Weekend 12+")
    @school_holiday_courses = Course.where(subtype: "School Holidays")
  end
end
