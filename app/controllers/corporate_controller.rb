class CorporateController < ApplicationController
  def index
    @demystify_tech = Course.find_by(name: "Demystify Tech")
    @transformer = Course.find_by(name: "Transformer")
    @intro_to_coding = Course.find_by(name: "Introduction To Coding")
    @courses = Course.where(course_type: "Corporate")
    @posts = Post.current_articles.first(3)
  end
end
