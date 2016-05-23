class Intake < ActiveRecord::Base
  belongs_to :course
  has_many :bookings

  validates :course, :start, :finish, :location, :class_size, presence: true
  validate :valid_finish

  def valid_finish
    if start && finish && start > finish
      errors.add(:finish, "finish cannot be before start")
    end
  end
end
