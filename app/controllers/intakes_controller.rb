class IntakesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @intakes = @course.intakes.paginate(:page => params[:page], :per_page => 10)
    else
      @courses = Course.all
    end
  end

  def show
    @intake = Intake.find(params[:id])
  end

  def new
    @intake = Intake.new
  end

  def create
    @intake = Intake.new(intake_params)
    if @intake.save
      redirect_to @intake
    else
      respond_with @intake
    end
  end

  def edit
    @intake = Intake.find(params[:id])
  end

  def update
    @intake = Intake.find(params[:id])
    if @intake.update_attributes(intake_params)
      redirect_to @intake
    else
      respond_with @intake
    end
  end

  def destroy
    @intake = Intake.find(params[:id])
    @post.destroy
    redirect_to intakes_path
  end

  private
  def intake_params
    params.require(:intake).permit(:course, :start, :finish, :location, :class_size)
  end
end
