class SendBookingEmailJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform(booking_id)
    ActiveRecord::Base.connection_pool.with_connection do
      BookingMailer.response(booking_id).deliver_now
      BookingMailer.received(booking_id).deliver_now
    end
  end
end
