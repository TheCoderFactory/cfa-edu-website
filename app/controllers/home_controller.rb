class HomeController < ApplicationController
  def index
    @intakes = Intake.all.reverse_chron_order.first(4)
  end
end
