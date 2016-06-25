class HomeController < ApplicationController
  def index
    @intakes = Intake.all.chron_order.first(4)
  end
end
