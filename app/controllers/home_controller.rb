class HomeController < ApplicationController
  def index
    @intakes = Intake.all.future_intakes.active_intakes.chron_order
    @intakes = @intakes.group("course_id", "location").having("start = MIN(start)").first(4)
    @posts = Post.current_articles.first(3)
  end
end
