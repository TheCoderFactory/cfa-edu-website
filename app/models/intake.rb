class Intake < ActiveRecord::Base
  belongs_to :course
  has_many :bookings, dependent: :restrict_with_error
  mount_uploader :teacher_image, TeacherImageUploader

  validates :course, :start, :finish, :location, :days, presence: true
  validates_inclusion_of :status, in: ["Active", "Cancelled", "Full"]
  validate :valid_finish

  def valid_finish
    if start && finish && start > finish
      errors.add(:finish, "finish cannot be before start")
    end
  end

  def self.future_intakes
    where("start >= ?", Date.today)
  end
  def self.active_intakes
    where(status: "Active")
  end
  def self.chron_order
    order(start: :asc)
  end
  def course_price
    course.get_price
  end
  def course_name
    course.name
  end
  def start_date
    start.strftime('%d %b %Y')
  end
  def start_time
    start.strftime("%I:%M %P").upcase
  end
  def finish_date
    finish.strftime('%d %b %Y')
  end
  def finish_time
    finish.strftime("%I:%M %P").upcase
  end
  def course_image
    return course.course_image_url if course.course_image_url
  end
end
