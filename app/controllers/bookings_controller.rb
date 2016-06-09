class BookingsController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, only: ["index", "show", "edit", "update", "destroy"]
  layout "admin", only: ["index", "show", "edit", "update", "destroy"]

  def index
    @intakes = Intake.all
  end

  def show
    @booking = Booking.find(params[:id])
    @payment = @booking.payment
  end

  def new
    @course = Course.find(params[:course_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    # @intake = Intake.find(booking_params[:intake_id])
    ################################################################
    ################################################################
    @amount = 500

    charge = Stripe::Charge.create(
      :source => params[:stripeToken],
      :amount => @amount,
      :description => 'Rails Stripe customer',
      :currency => 'aud'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    ################################################################
    ################################################################
    if @booking.save
      redirect_to confirmation_path
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
    @intake = @booking.intake
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
    params.require(:booking).permit(:intake_id, :promo_code, :people_attending, :total_cost, :name, :email, :phone, :age, :city, :country)
  end
end
