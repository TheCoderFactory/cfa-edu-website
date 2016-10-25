class CorporateController < ApplicationController
  def index
    @courses = Course.where(course_type: "Corporate")
    @course1 = @courses.find_by(name: "Digital Pioneer Program")
    @course2 = @courses.find_by(name: "Business App Builder")
    @course3 = @courses.find_by(name: "Power of Code")
    @posts = Post.current_articles.first(3)
  end
end
