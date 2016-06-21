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
    @booking = Booking.new(booking_params.except!(:promo_code))
    @intake = Intake.find(booking_params[:intake_id])
    @course = @intake.course

    @promo_code = PromoCode.find_by(code: booking_params[:promo_code])
    @booking.promo_code = @promo_code
    @percent = 1
    @percent -= @promo_code.percent*0.01 if @promo_code

    ################################################################
    ################################################################
    total_people = booking_params[:people_attending].to_i
    @amount = get_total_amount @booking.total_cost, total_people, @percent
    @booking.total_cost = @amount

    charge = Stripe::Charge.create(
      :source => params[:stripeToken],
      :amount => @amount,
      :description => 'Rails Stripe customer',
      :currency => 'aud'
    )

    @payment = Payment.new(amount: @amount, paid: charge.paid)
    ################################################################
    ################################################################
    if @payment.save && @booking.save
      redirect_to confirmation_path
    else
      puts "LLLLL"
      puts @booking.errors.inspect
      respond_with @booking
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
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
    params.require(:booking).permit(:intake_id, :promo_code, :people_attending, :total_cost, :firstname, :lastname, :email, :phone, :age, :city, :country)
  end

  def get_total_amount price, people_attending, percent
    ((price*people_attending*percent)*100).to_i
  end
end
