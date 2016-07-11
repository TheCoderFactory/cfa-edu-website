class HomeController < ApplicationController
  def index
    @intakes = Intake.all.future_intakes.chron_order.first(4)
    @posts = Post.current_articles.first(3)
  end
end
