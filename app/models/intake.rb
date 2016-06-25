class Intake < ActiveRecord::Base
  belongs_to :course
  has_many :bookings, dependent: :restrict_with_error
  mount_uploader :teacher_image, TeacherImageUploader

  validates :course, :start, :finish, :location, :days, presence: true
  validate :valid_finish

  def valid_finish
    if start && finish && start > finish
      errors.add(:finish, "finish cannot be before start")
    end
  end

  def self.chron_order
    order(start: :asc)
  end
  def intake_available?
    # total_attendees = 0
    # bookings.each { |b| total_attendees+=b.people_attending }
    # return true if total_attendees < class_size
    # return false
    true
  end
  def course_price
    course.get_price
  end
  def course_name
    course.name
  end
  def start_date
    start.strftime('%d %B %Y')
  end
  def start_time
    start.strftime("%I:%M %P").upcase
  end
  def finish_date
    finish.strftime('%d %B %Y')
  end
  def finish_time
    finish.strftime("%I:%M %P").upcase
  end
end
