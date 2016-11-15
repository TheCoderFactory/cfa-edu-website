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
    if price && price < -1.00
      errors.add(:price, "price cannot be negative")
    end
  end

  def active_syd_intakes
    active_intakes.where("location LIKE ?", "%Sydney%").order(start: :asc)
  end

  def active_mel_intakes
    active_intakes.where("location LIKE ?", "%Melbourne%").order(start: :asc)
  end

  def active_intakes
    intakes.where.not(status: "Cancelled").where.not(status: "Finished")
  end

  def available?
    return false if active_intakes.size == 0
    return true
  end

  def get_price
    return "TAILORED PRICES" if price < 0.0
    if (price > 0.0)
      if price%1 == 0
        return "$#{price.to_i} + GST #{per}"
      else
        return "$#{price} + GST #{per}"
      end
    end
    return "FREE"
  end
end
