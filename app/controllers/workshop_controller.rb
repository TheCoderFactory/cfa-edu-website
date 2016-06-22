class WorkshopController < ApplicationController
  def index
    @courses = Course.where(course_type: "Workshop")
  end
end
