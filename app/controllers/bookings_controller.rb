class BookingsController < ApplicationController
  before_action :authenticate_admin!, only: ["index", "show", "edit", "update", "destroy"]
  layout "admin", only: ["index", "show", "edit", "update", "destroy"]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @intake = Intake.find(params[:intake_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking
    else
      respond_with @booking
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @intake = @booking.intake
  end

  def update
    @booking = Booking.find(params[:id])
    @intake = Intake.find(booking_params[:intake_id])
    if @booking.update_attributes(booking_params)
      redirect_to @booking
    else
      respond_with @booking
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:intake_id, :promo_code, :people_attending, :total_cost)
  end
end
