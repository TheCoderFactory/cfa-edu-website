class CorporateController < ApplicationController
  def index
    @courses = Course.where(course_type: "Corporate")
    @posts = Post.all.reverse_chron_order.first(3)
  end
end
