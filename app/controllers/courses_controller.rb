class CoursesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    @fail = true if params[:failed_delete]
    @workshop_courses = Course.where(course_type: "Workshop").paginate(:page => params[:page], :per_page => 5)
    @corporate_courses = Course.where(course_type: "Corporate").paginate(:page => params[:page], :per_page => 5)
    @kids_coding_courses = Course.where(course_type: "Kids Coding").paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @course = Course.find(params[:id])
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
    @course.destroy
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:course_type, :name, :description, :tagline, :price)
  end
end
