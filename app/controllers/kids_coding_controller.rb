class KidsCodingController < ApplicationController
  def index
    @weekend_courses = Course.where(course_type: "Kids").where("subtype like ?", "%Weekend%")
    @weekend_primary_courses = @weekend_courses.where(subtype: "Weekend Primary")
    @weekend_secondary_courses = @weekend_courses.where(subtype: "Weekend Secondary")
    @sh_courses = Course.where(course_type: "Kids").where("subtype like ?", "%School Holidays%")
    @sh_primary_courses = @sh_courses.where(subtype: "School Holidays Primary")
    @sh_secondary_courses = @sh_courses.where(subtype: "School Holidays Secondary")
  end
end
