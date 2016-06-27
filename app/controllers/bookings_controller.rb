class BookingsController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, only: ["index", "show", "edit", "update", "destroy"]
  layout "admin", only: ["index", "show", "edit", "update", "destroy"]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @payment = @booking.payment
  end

  def new
    @course = Course.friendly.find(params[:course_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params.except!(:promo_code))
    @intake = Intake.find(booking_params[:intake_id])
    @course = @intake.course

    @promo_code = PromoCode.find_by(code: booking_params[:promo_code])
    @booking.promo_code = @promo_code

    percent = 1
    percent -= @promo_code.percent*0.01 if @promo_code
    total_people = booking_params[:people_attending].to_i
    cost = @booking.total_cost

    @amount = get_total_amount cost, total_people, percent
    @booking.total_cost = @amount

    if @amount > 50
      customer = Stripe::Customer.create(
        :email => @booking.email,
        :source  => params[:stripeToken]
      )
      charge = Stripe::Charge.create(
        :customer => customer,
        :amount => @amount,
        :description => 'Rails Stripe customer',
        :currency => 'aud'
      )
    end

    @payment = Payment.new(amount: @amount, paid: charge ? charge.paid : true , booking: @booking)

    if @payment.save && @booking.save
      @booking.send_emails
      redirect_to confirmation_path
    else
      puts @booking.errors.inspect
      puts @payment.errors.inspect
      render :new
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
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
    total = price*people_attending
    total+=(total/10)
    total*=percent
    return (total*100).to_i
  end
end
