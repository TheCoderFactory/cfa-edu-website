class Intake < ActiveRecord::Base
  belongs_to :course
  has_many :bookings, dependent: :restrict_with_error

  validates :course, :start, :finish, :location, :class_size, presence: true
  validate :valid_finish

  def valid_finish
    if start && finish && start > finish
      errors.add(:finish, "finish cannot be before start")
    end
  end
  def intake_available?
    total_attendees = 0
    bookings.each { |b| total_attendees+=b.people_attending }
    return true if total_attendees < class_size
    return false
  end
end
