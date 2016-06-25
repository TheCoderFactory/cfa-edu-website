class IntakesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    @intakes = Intake.all
  end

  def show
    @intake = Intake.find(params[:id])
    @bookings = @intake.bookings
  end

  def new
    @course = Course.friendly.find(params[:course_id]) if params[:course_id]
    @courses = Course.all
    @intake = Intake.new
  end

  def create
    @intake = Intake.new(intake_params)
    @course = Course.friendly.find(intake_params[:course_id])
    if @intake.save
      redirect_to @intake
    else
      respond_with @intake
    end
  end

  def edit
    @intake = Intake.find(params[:id])
    @course = @intake.course
  end

  def update
    @intake = Intake.find(params[:id])
    @course = @intake.course
    if @intake.update_attributes(intake_params)
      redirect_to @intake
    else
      respond_with @intake
    end
  end

  def destroy
    @intake = Intake.find(params[:id])
    @intake.destroy
    redirect_to intakes_path
  end

  private
  def intake_params
    params.require(:intake).permit(:course_id, :start, :finish, :location, :teacher_name, :teacher_image, :days, :status)
  end
end
