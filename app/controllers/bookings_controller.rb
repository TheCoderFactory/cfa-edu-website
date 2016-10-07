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
    session[:booking_params] = {}
    session[:booking_step] = session[:campus] = session[:promo_code] = session[:intake] = nil
    puts session.inspect
    @course = Course.friendly.find(params[:course_id])
    @booking = Booking.new(session[:booking_params])
  end

  def create
    @course = Course.friendly.find(params["course_id"])

    session[:booking_params].deep_merge!(params[:booking]) if params[:booking]
    @booking = Booking.new(session[:booking_params])

    @syd_intakes, @mel_intakes = @course.active_syd_intakes, @course.active_mel_intakes

    session[:campus] = params[:campus] if params[:campus]
    if session[:campus] == "Sydney"
      session[:intake] = params[:syd_intake] if params[:syd_intake]
    elsif session[:campus] == "Melbourne"
      session[:intake] = params[:mel_intake] if params[:mel_intake]
    end
    @booking.intake = Intake.find(session[:intake]) if session[:intake]

    session[:promo_code] = params[:promo_code] if params[:promo_code]
    @promo_code = PromoCode.find_by(code: session[:promo_code])
    @booking.promo_code = @promo_code

    @amount = get_amount @booking
    @booking.total_cost = @amount

    @booking.current_step = session[:booking_step]
    if @booking.valid?
      if params[:back_button]
        @booking.previous_step
      elsif params[:confirm_button]
        @booking.save if @booking.all_valid?
      elsif @booking.campus_step?
        @booking.next_step if @booking.intake
      elsif @booking.last_step?
        if @booking.all_valid?
          @booking.transaction do
            begin
              if @booking.save
                charge = charge_customer (@amount*100).to_i, @booking
                payment = Payment.new(amount: @amount, paid: charge ? charge.paid : true , booking: @booking)
                if payment.save
                  @booking.update_attributes({payment: payment})
                  @booking.send_emails
                end
              end
            rescue Stripe::CardError => e
              flash[:error] = e.message
              raise ActiveRecord::Rollback
            end
          end
        end
      else
        @booking.next_step
      end
      session[:booking_step] = @booking.current_step
    end
    if @booking.new_record?
      render :new
    else
      session[:booking_params] = nil
      session[:booking_step] = session[:campus] = session[:promo_code] = session[:intake] = nil
      redirect_to confirmation_path
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

  def get_amount booking
    cost, percent = 0, 1
    percent -= booking.promo_code.percent*0.01 if booking.promo_code
    cost = booking.intake.course.price if booking.intake
    @gst = cost*0.1
    cost+=@gst
    final_cost = cost*percent
    @discount = cost-final_cost
    return final_cost
  end

  def charge_customer amount, booking
    if amount > 50
      customer = Stripe::Customer.create(
        :email => booking.email,
        :source  => params[:stripeToken]
      )
      charge = Stripe::Charge.create(
        :customer => customer,
        :amount => amount,
        :description => 'Short Course Booking',
        :currency => 'aud'
      )
      return charge
    end
  end
end
