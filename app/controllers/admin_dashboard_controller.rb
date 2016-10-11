class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  layout "admin"

  def index
    intakes = Intake.all.includes(:course).order(start: :asc)
    this_month = intakes.reject{ |i| i.start.month != DateTime.now.month }
    next_month = intakes.reject{ |i| i.start.month != (DateTime.now + 1.month).month }
    @upcoming_intakes = this_month.zip(next_month)
    bookings = Booking.where("created_at >= ?", Date.today-30.days).includes(:intake)
    @booking_count = Hash[(30.days.ago.to_date..Date.today).map{ |date| date.strftime("%b %d %Y") }.collect{|v| [v, 0]}]
    bookings.each {|b| @booking_count[b.created_at.strftime("%b %d %Y")]+=1}
    @booking_hash = @booking_count.inject([]) {|arr, v| arr << v}
    @booking_count = bookings.count
    @syd_pie_bookings = reduce_bookings bookings, "Sydney"
    @mel_pie_bookings = reduce_bookings bookings, "Melbourne"
  end

  private
  def reduce_bookings bookings, str
    bookings.inject(Hash.new(0) { |hash, i| hash[i.course_name]+=1 if i.course_location.include?(str); hash }
  end
end
