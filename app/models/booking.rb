class Booking < ActiveRecord::Base
  include CsvModel
  belongs_to :intake
  belongs_to :promo_code
  has_one :payment

  attr_writer :current_step

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :format => EMAIL_REGEX, if: lambda {|o| o.current_step == "personal_details"}
  validates_presence_of :firstname, :lastname, :email, :phone,:age, :city, :country,
    if: lambda {|o| o.current_step == "personal_details"}
  validates_presence_of :intake, if: lambda {|o| o.current_step == "campus"}
  validate :active_intake, on: :create, if: lambda {|o| o.current_step == "campus"}
  validate :valid_promo_code, on: :create, if: lambda {|o| o.current_step == "confirmation"}
  validates_presence_of :total_cost, if: lambda {|o| o.current_step == "payment"}
  validate :valid_total_cost, :non_negative_total_cost, on: :create, if: lambda {|o| o.current_step == "payment"}

  def active_intake
    if intake && !intake.active?
      errors.add(:intake, "can't select a full intake")
    end
  end
  def valid_promo_code
    if promo_code && !promo_code.valid_code
      errors.add(:promo_code, "not a valid code")
    end
  end
  def valid_total_cost
    percent = 1
    percent -= promo_code.percent*0.01 if promo_code
    if intake && total_cost && people_attending
      cost = intake.course.price
      # include gst
      cost+=(cost/10)
      cost*=percent*100
      if total_cost > cost || total_cost < cost
        errors.add(:total_cost, "total_cost must be equal to course.price*people_attending + gst")
      end
    end
  end
  def non_negative_total_cost
    if total_cost && total_cost < 0.00
      errors.add(:total_cost, "total_cost cannot be negative")
    end
  end

  def paid?
    payment ? payment.paid : true
  end
  def course_name
    intake.course_name
  end
  def amount_paid
    payment.amount
  end
  def cost_in_dollars
    return "$#{total_cost}"
  end
  def course_location
    intake.location
  end
  def start_date
    intake.start_date
  end
  def finish_date
    intake.finish_date
  end
  def start_time
    intake.start_time
  end
  def finish_time
    intake.finish_time
  end
  def days
    intake.days
  end
  def send_emails
    SendBookingEmailJob.perform_async(self.id)
  end

  def current_step
    @current_step || steps.first
  end
  def steps
    %w[campus personal_details confirmation payment]
  end
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  def first_step?
    current_step == steps.first
  end
  def last_step?
    current_step == steps.last
  end
  def confirmation_step?
    current_step ==  "confirmation"
  end
  def campus_step?
    current_step == "campus"
  end
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def update_promo_code
    if promo_code && promo_code.code_type == "Number of Uses"
      promo_code.update_attribute(:number_of_uses, promo_code.number_of_uses-1)
      promo_code.update_attribute(:valid_code, false) if promo_code.number_of_uses <= 0
    end
  end
end
