class IntakesController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, except: ["intake_details"]
  layout "admin"

  def index
    @intakes = Intake.all.includes(:course)
    @intakes = Intake.where("start >= ?", DateTime.now) if params[:future]
  end

  def show
    @intake = Intake.find(params[:id])
    @bookings = @intake.bookings
    @active_bookings = @intake.bookings.where(cancelled: false)
    @cancelled_bookings = @intake.bookings.where(cancelled: true)

    respond_to do |format|
      format.html
      format.csv { send_data @bookings.to_csv }
    end
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

  def intake_details
    @intake = Intake.find(intake_id_param[:intake_id])
    if @intake
      render json: { success: true, exists: true, start_date: @intake.start_date, finish_date: @intake.finish_date, start_time: @intake.start_time, finish_time: @intake.finish_time }
    else
      render json: { success: false, exists: false }
    end
  end

  private
  def intake_params
    params.require(:intake).permit(:course_id, :start, :finish, :location, :teacher_name, :teacher_image, :days, :status)
  end

  def intake_id_param
    params.permit(:intake_id)
  end
end
