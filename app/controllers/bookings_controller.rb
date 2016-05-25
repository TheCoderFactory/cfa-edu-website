class BookingsController < ApplicationController
  before_action :authenticate_admin!, only: ["index"]
  layout "admin", only: ["index"]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
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
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(booking_params)
      redirect_to @booking
    else
      respond_with @booking
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @post.destroy
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:intake, :promo_code, :people_attending, :total_cost)
  end
end
