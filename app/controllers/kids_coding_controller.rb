class KidsCodingController < ApplicationController
  def index
    @courses = Course.where(course_type: "Schools")
  end
end
