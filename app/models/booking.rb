class Booking < ActiveRecord::Base
  belongs_to :intake
  belongs_to :promo_code
  has_one :payment

  validates :intake, :people_attending, :total_cost,
    :firstname, :lastname, :email, :phone, :age, :city, :country, presence: true
  validate :valid_total_cost, :non_negative_total_cost, :intake_not_full

  def valid_total_cost
    promo_code ? percent = promo_code.percent : percent = 0
    if intake && total_cost && people_attending
      if total_cost > intake.course.price*people_attending*(100-percent)/100*100 || total_cost < intake.course.price*people_attending*(100-percent)/100*100
        errors.add(:total_cost, "total_cost must be equal to course.price*people_attending")
      end
    end
  end
  def non_negative_total_cost
    if total_cost && total_cost < 0.00
      errors.add(:total_cost, "total_cost cannot be negative")
    end
  end
  def intake_not_full
    if intake && people_attending
      total_attendees = 0
      intake.bookings.each { |b| total_attendees+=b.people_attending }
      if total_attendees+people_attending > intake.class_size
        errors.add(:intake, "intake full")
      end
    end
  end
end
