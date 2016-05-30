class IntakesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!
  layout "admin"

  def index
    # Show intakes through corresponding course
    @courses = Course.all
  end

  def show
    @intake = Intake.find(params[:id])
    @bookings = @intake.bookings.paginate(page: params[:page], per_page: 5)
  end

  def new
    @course = Course.find(params[:course_id])
    @intake = Intake.new
  end

  def create
    @intake = Intake.new(intake_params)
    @course = Course.find(intake_params[:course_id])
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
    params.require(:intake).permit(:course_id, :start, :finish, :location, :class_size)
  end
end
