class Booking < ActiveRecord::Base
  belongs_to :intake
  belongs_to :promo_code
  has_one :payment

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :format => EMAIL_REGEX
  validates :intake, :people_attending, :total_cost,
    :firstname, :lastname, :email, :phone, :age, :city, :country, presence: true
  validate :valid_total_cost, :non_negative_total_cost

  def valid_total_cost
    percent = 1
    percent -= promo_code.percent*0.01 if promo_code
    if intake && total_cost && people_attending
      amount = intake.course.price*people_attending*percent*100
      # include gst
      amount+=amount/10
      if total_cost > amount || total_cost < amount
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
    payment.paid
  end
  def course_name
    intake.course_name
  end
  def amount_paid
    payment.amount
  end
  def cost_in_dollars
    total_cost/100
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
end
