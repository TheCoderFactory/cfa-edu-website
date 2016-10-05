class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  layout "admin"

  def index
    this_month = Intake.all.reject{ |i| i.start.month != DateTime.now.month }.sort{|x, y| x <=> y}
    this_month.map! {|i| i.course_name+','+i.start_date }
    next_month = Intake.all.reject{ |i| i.start.month != DateTime.now.month + 1.month }.sort{|x, y| x <=> y}
    next_month.map! {|i| i.course_name+','+i.start_date }
    @upcoming_intakes = this_month.zip(next_month)
    bookings = Booking.where("created_at >= ?", Date.today-30.days)
    @booking_count = Hash[(30.days.ago.to_date..Date.today).map{ |date| date.strftime("%b %d") }.collect{|v| [v, 0]}]
    bookings.each {|b| @booking_count[b.start_date.strftime("%b %d")]+=1}
    @pie_bookings = bookings.inject(Hash.new(0)) { |hash, i|  hash[i.course_name]+=1; hash }
  end
end
