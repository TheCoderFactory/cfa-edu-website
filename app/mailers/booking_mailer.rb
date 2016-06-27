class BookingMailer < ApplicationMailer
  default from: "Coder Factory Bookings <info@coderfactory.com>"

  def response(booking_id)
    @booking = Booking.find(booking_id)
    mail(to: @booking.email, subject: "#{@booking.firstname} , thanks for your booking!.")
  end

  def received(booking_id)
    @booking = Booking.find(booking_id)
    mail(to: "info@coderfactory.com", subject: "New booking for #{@booking.course_name}")
  end
end
