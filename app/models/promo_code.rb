class PromoCode < ActiveRecord::Base
  has_many :bookings

  validates :code, :percent, :note, :code_type, presence: true
  validates :code_type, inclusion: {in: ["Expiry Date", "Number of Uses"]}
  validates_presence_of :expiry_date, if: lambda {|o| o.code_type == "Expiry Date"}
  validates_presence_of :number_of_uses, if: lambda {|o| o.code_type == "Number of Uses"}
  validates :code, uniqueness: true

  after_create :schedule_deactivate_code_job

  def to_s
    code
  end

  def schedule_deactivate_code_job
    if code_type == "Expiry Date" && expiry_date
      time = ((expiry_date - Date.today)*24*60*60).to_i
      DeactivateCodeJob.perform_in(time, id)
    end
  end
end
