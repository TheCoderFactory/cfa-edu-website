class PromoCode < ActiveRecord::Base
  has_many :bookings

  validates :code, :percent, :note, presence: true
  validates :code, uniqueness: true
end
