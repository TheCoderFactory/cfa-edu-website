class PromoCode < ActiveRecord::Base
  has_many :bookings

  validates :code, :percent, :note, presence: true
  validates :code, uniqueness: true

  def to_s
    code
  end
end
