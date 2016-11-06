class KidsCodingController < ApplicationController
  def index
    @weekend_courses = Course.where(subtype: "Weekend")
    @school_holiday_courses = Course.where(subtype: "School Holidays")
  end
end
