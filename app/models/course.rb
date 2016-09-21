class Course < ActiveRecord::Base
  extend FriendlyId
  mount_uploader :course_image, CourseImageUploader
  has_many :intakes, dependent: :restrict_with_error
  friendly_id :name, use: :slugged

  validates :course_type, :name, :description, :tagline, :price, presence: true
  validate :non_negative_price

  def self.active_courses
    where(active: true)
  end

  def non_negative_price
    if price && price < 0.00
      errors.add(:price, "price cannot be negative")
    end
  end

  def active_intakes
    intakes.where(status: "Active")
  end

  def available?
    return false if active_intakes.size == 0
    return true
  end

  def get_price
    if (price > 0.0)
      if price%1 == 0
        return "$#{price.to_i} + GST"
      else
        return "$#{price} + GST"
      end
    end
    return "FREE"
  end
end
