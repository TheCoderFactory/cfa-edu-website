class FastTrackPayment < ActiveRecord::Base
  validates :first_name, :last_name, :email, :pay_type, :student_id, :amount, presence: true
  validates_inclusion_of :paid, in: [true, false]
end
