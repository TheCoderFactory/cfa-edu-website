class CoursesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    @courses = Course.all
    @course_type = params[:course_type] if params[:course_type]
    @courses = Course.where(course_type: @course_type) if @course_type
  end

  def show
    @course = Course.friendly.find(params[:id])
    @intakes = @course.intakes
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
    @course = Course.friendly.find(params[:id])
  end

  def update
    @course = Course.friendly.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to @course
    else
      respond_with @course
    end
  end

  def destroy
    @course = Course.friendly.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:course_type, :subtype, :name, :description, :tagline, :price, :per, :course_image, :active, :order)
  end
end
