class CoursesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    @workshop_courses = Course.where(course_type: "Workshop").paginate(:page => params[:page], :per_page => 5)
    @corporate_courses = Course.where(course_type: "Corporate").paginate(:page => params[:page], :per_page => 5)
    @schools_courses = Course.where(course_type: "Schools").paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @course = Course.friendly.find(params[:id])
    @intakes = @course.intakes.paginate(page: params[:page], per_page: 5)
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
    params.require(:course).permit(:course_type, :name, :description, :tagline, :price)
  end
end
