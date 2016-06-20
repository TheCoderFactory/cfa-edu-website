class Course < ActiveRecord::Base
  has_many :intakes, dependent: :restrict_with_error

  validates :course_type, :name, :description, :tagline, :price, presence: true
  validate :non_negative_price

  def non_negative_price
    if price && price < 0.00
      errors.add(:price, "price cannot be negative")
    end
  end

  def available?
    return false if intakes.size == 0
    return true
  end

  def available_intakes
    av_intakes = []
    intakes.each { |i| av_intakes << i if i.intake_available?}
    return av_intakes
  end
end
