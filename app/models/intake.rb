class Intake < ActiveRecord::Base
  belongs_to :course
  has_many :bookings, dependent: :restrict_with_error
  mount_uploader :teacher_image, TeacherImageUploader

  validates :course, :start, :finish, :location, :days, presence: true
  validates_inclusion_of :status, in: ["Active", "Cancelled", "Full", "Finished"]
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
    where.not(status: "Cancelled")
  end
  def self.chron_order
    order(start: :asc)
  end
  def self.all_full?
    return false if !any?
    where.not(status: "Cancelled").map { |i| return false if i.status != "Full" }
    return true
  end
  def self.first_active
    where(status: "Active").first
  end
  def active_bookings
    bookings.where.not(cancelled: true)
  end
  def active?
    status == "Active"
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
  def course_type
    course.course_type
  end
  def get_dates
    "#{"~"+status.upcase+"~" if status == "Full"} #{days}, #{start_date} (#{start_time} - #{finish_time}), End: #{finish_date}"
  end
end
