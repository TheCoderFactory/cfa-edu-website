class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  layout "admin"

  def index
    this_month = Intake.all.reject{ |i| i.start.month != DateTime.today.month }.map {|i| i.course_name+','+i.start_date }
    next_month = Intake.all.reject{ |i| i.start.month != DateTime.today.month + 1.month }.map {|i| i.course_name+','+i.start_date }
    @upcoming_intakes = this_month.zip(next_month)
    @bookings = Booking.where("created_at <= ?", Date.today-30.days)
    @pie_bookings = @bookings.inject(Hash.new(0)) { |hash, i|  hash[i.course_name]+=1; hash }
  end
end
