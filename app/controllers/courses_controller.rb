class CoursesController < ApplicationController
  before_action :authenticate_admin!, only: ["index"]
  layout "admin", only: ["index"]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      respond_with @course
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to @course
    else
      respond_with @course
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @post.destroy
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:course_type, :name, :description, :tagline, :price)
  end
end
