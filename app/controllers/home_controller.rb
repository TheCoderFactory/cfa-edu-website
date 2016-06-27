class HomeController < ApplicationController
  def index
    @intakes = Intake.all.chron_order.first(4)
    @posts = Post.all.reverse_chron_order.first(3)
  end
end
