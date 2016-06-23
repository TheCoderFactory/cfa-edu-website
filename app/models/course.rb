class Course < ActiveRecord::Base
  extend FriendlyId
  has_many :intakes, dependent: :restrict_with_error
  friendly_id :name, use: :slugged

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

  def get_price
    if course_type == "Workshop"
      if (price > 0.0)
        if price%1 == 0
          return "$#{price.to_i} + GST"
        else
          return "$#{price} + GST"
        end
      end
      return "FREE"
    end
    return "$#{price} + GST"
  end
end
