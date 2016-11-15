class BookingsController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, only: ["index", "show", "admin_new", "admin_create", "edit", "update", "destroy"]
  layout "admin", only: ["index", "show", "admin_new", "admin_create", "edit", "update", "destroy"]

  def index
    @bookings = Booking.all.includes(:intake => :course).includes(:payment)
    @cbookings = Booking.where(cancelled: true).includes(:intake => :course).includes(:payment)
  end

  def show
    @booking = Booking.find(params[:id])
    @payment = @booking.payment
  end

  def new
    session[:booking_params] = {}
    session[:booking_step] = session[:campus] = session[:promo_code] = session[:intake] = nil
    @course = Course.friendly.find(params[:course_id])
    @syd_intakes, @mel_intakes = @course.active_syd_intakes, @course.active_mel_intakes
    @booking = Booking.new(session[:booking_params])
  end

  def create
    @course = Course.friendly.find(params["course_id"])
    @syd_intakes, @mel_intakes = @course.active_syd_intakes, @course.active_mel_intakes

    session[:booking_params].deep_merge!(booking_params) if params[:booking]
    session[:booking_params].deep_merge!(stripe_token: params[:stripeToken]) if params[:stripeToken]
    @booking = Booking.new(session[:booking_params])

    session[:campus] = params[:campus]
    if session[:campus] == "Sydney"
      session[:intake] = params[:syd_intake] if params[:syd_intake]
    elsif session[:campus] == "Melbourne"
      session[:intake] = params[:mel_intake] if params[:mel_intake]
    end
    @booking.intake = Intake.find(session[:intake]) if session[:intake]

    @booking.current_step = session[:booking_step]
    if params[:back_button]
      @booking.previous_step
    elsif @booking.valid?
      if @booking.last_step? || params[:confirm_button]
        @booking.send_emails if @booking.all_valid? && @booking.save
      else
        @booking.next_step
      end
    end
    session[:booking_step] = @booking.current_step
    if @booking.new_record?
      flash[:danger] = @booking.errors.reduce([]) { |arr, b| arr << "#{b[0].capitalize} #{b[1]}"; arr }
      render :new
    else
      session[:booking_params] = session[:booking_step] = session[:campus] = session[:promo_code] = session[:intake] = nil
      redirect_to confirmation_path
    end
  end

  def admin_new
    @booking = Booking.new
    @booking.intake_id = params[:intake_id] if params[:intake_id]
    @intakes = Intake.all
  end

  def admin_create
    @booking = Booking.new(booking_params)
    @intakes = Intake.all
    if @booking.save(validate: false)
      @booking.send_emails
      redirect_to @booking
    else
      puts @booking.errors.inspect
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @intakes = Intake.all
  end

  def update
    @booking = Booking.find(params[:id])
    @intakes = Intake.all
    if @booking.update_attributes(booking_params)
      redirect_to @booking
    else
      puts @booking.errors.inspect
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:intake_id, :promo_code, :people_attending, :total_cost, :firstname, :lastname, :email, :phone, :age, :city, :country, :cancelled, :discount_code)
  end
end
