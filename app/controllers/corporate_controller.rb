class CorporateController < ApplicationController
  def index
    @course1 = Course.find_by(name: "Digital Pioneer")
    @course2 = Course.find_by(name: "Transformer")
    @course3 = Course.find_by(name: "Introduction To Coding")
    @courses = Course.where(course_type: "Corporate")
    @posts = Post.current_articles.first(3)
  end
end
