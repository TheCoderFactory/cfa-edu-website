class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  layout "admin"

  def index
    this_month = Intake.all.order(start: :asc).reject{ |i| i.start.month != DateTime.now.month }
    this_month = Intake.first(4)
    next_month = Intake.all.order(start: :asc).reject{ |i| i.start.month != (DateTime.now + 1.month).month }
    @upcoming_intakes = this_month.zip(next_month)
    bookings = Booking.where("created_at >= ?", Date.today-30.days)
    @booking_count = Hash[(30.days.ago.to_date..Date.today).map{ |date| date.strftime("%b %d %Y") }.collect{|v| [v, 0]}]
    bookings.each {|b| @booking_count[b.created_at.strftime("%b %d %Y")]+=1}
    @booking_hash = @booking_count.inject([]) {|arr, v| arr << v}
    @booking_count = bookings.count
    puts @booking_count.inspect
    @syd_pie_bookings = bookings.inject(Hash.new(0)) { |hash, i|  hash[i.course_name]+=1 if i.course_location.include?("Sydney"); hash }
    @mel_pie_bookings = bookings.inject(Hash.new(0)) { |hash, i|  hash[i.course_name]+=1 if i.course_location.include?("Melbourne"); hash }
  end
end
