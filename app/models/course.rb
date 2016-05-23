class Course < ActiveRecord::Base
  has_many :intakes

  validates :course_type, :name, :description, :tagline, :price, presence: true
  validate :non_negative_price

  def non_negative_price
    if price && price < 0.00
      errors.add(:price, "price cannot be negative")
    end
  end
end
