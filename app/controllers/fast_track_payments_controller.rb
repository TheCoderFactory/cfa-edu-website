class FastTrackPaymentsController < ApplicationController
  respond_to :html
  before_action :authenticate_admin!, except: ["new", "create"]
  layout "admin", except: ["new", "create"]

  def index
    @fast_track_payments = FastTrackPayment.all
  end

  def show
    @fast_track_payment = FastTrackPayment.find(params[:id])
  end

  def new
    @fast_track_payment = FastTrackPayment.new
    @payment_type = params[:pay_type]
    @student_id = params[:student_id]
    @amount = payment_amount @payment_type
  end

  def create
    @payment_type = fast_track_payment_params[:pay_type]
    @student_id = fast_track_payment_params[:student_id]
    @amount = payment_amount @payment_type
    @fast_track_payment = FastTrackPayment.create(fast_track_payment_params)
    @fast_track_payment.update_attributes({amount: @amount, paid: false})
    if @fast_track_payment.save
      if !@amount.nil?
        customer = Stripe::Customer.create(
          :email => fast_track_payment_params[:email],
          :metadata => {student_id: @student_id, payment_type: @payment_type},
          :source  => params[:stripeToken]
        )
        charge = create_charge customer, @amount
        @fast_track_payment.update_attribute(:paid, charge.paid)
        redirect_to confirmation_path(type: "fast track invoice payment")
      else
        render :new
      end
    else
      respond_with @fast_track_payment
    end
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    @fast_track_payment.delete
    render :new
  end

  def edit
    @fast_track_payment = FastTrackPayment.find(params[:id])
    @payment_type = @fast_track_payment.pay_type
    @student_id = @fast_track_payment.student_id
    @amount = @fast_track_payment.amount
  end

  def update
    @fast_track_payment = FastTrackPayment.find(params[:id])
    if @fast_track_payment.update_attributes(fast_track_payment_params)
      redirect_to fast_track_payments_path
    else
      respond_with @fast_track_payment
    end
  end

  def destroy
    @fast_track_payment = FastTrackPayment.find(params[:id])
    @fast_track_payment.destroy
    redirect_to fast_track_payments_path
  end

  private
  def fast_track_payment_params
    params.require(:fast_track_payment).permit(:email, :student_id, :pay_type, :first_name, :last_name)
  end

  def payment_amount ptype
    case ptype.downcase
    when "domestic"
      return 292500
    when "international"
      return 323700
    when "wit-dom"
      return 98500
    when "wit-int"
      return 124750
    else
      return nil
    end
  end
  def create_charge customer, amount
    charge = Stripe::Charge.create(
      :customer => customer,
      :amount => amount,
      :description => 'Rails Stripe customer',
      :currency => 'aud'
    )
    return charge
  end
end
