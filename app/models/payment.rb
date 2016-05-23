class Payment < ActiveRecord::Base
  belongs_to :booking

  validates :booking, :amount, presence: true
  validate :non_negative_amount, :amount_equals_booking_cost

  def non_negative_amount
    if amount && amount < 0.00
      errors.add(:amount, "amount cannot be negative")
    end
  end
  def amount_equals_booking_cost
    if booking && amount && booking.total_cost != amount
      errors.add(:amount, "amount must equal the booking cost")
    end
  end
end
