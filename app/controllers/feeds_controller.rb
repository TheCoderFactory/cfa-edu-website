class FeedsController < ApplicationController
  layout false

  def blog
    @posts = Post.current_articles
  end

  def course
    @intakes = 
  end
end
